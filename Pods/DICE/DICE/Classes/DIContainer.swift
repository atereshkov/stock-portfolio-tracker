//
//  DIContainer.swift
//  DICE
//
//  Created by Alexander Tereshkov on 7/9/20.
//

import Foundation

public final class DIContainer: CustomStringConvertible {
    
    private(set) var id: String = UUID().uuidString
    
    private(set) var containerStorage = DIContainerStorage()
    lazy private(set) var resolveStorage: [DependencyKey: Any] = [:]
    
    lazy private(set) var resolveObjectGraphStorage: [DependencyKey: Any] = [:]
    private(set) var objectGraphStackDepth: Int = 0
    
    public var description: String {
        let descr = containerStorage.storedObjects.description
        return String(format: "[DIContainer %@] %@", id, descr)
    }
    
    public init() {
        
    }
    
}

// MARK: API

extension DIContainer {
    
    @discardableResult
    public func register<T>(
        _ type: T.Type = T.self,
        tag: String? = "",
        scope: DIScope? = nil,
        _ closure: @escaping (DIContainer) -> T
    ) -> DIContainerBuilder<T> {
        let scope = scope ?? DICE.Defaults.scope
        
        let initer = LazyObject(initBlock: closure, container: self)
        let key = DependencyKey(type: type, tag: tag)
        let object = DIObject(lazy: initer, type: type, scope: scope, key: key)
        
        // Add singleton objects to instantiate objects right away before building to make it accessible right after injection and resolving nested dependencies
        // Also avoids race condition reported in https://github.com/DICE-Swift/dice/issues/8
        if object.scope == .single {
            let resolvedObject = closure(self) as Any
            resolveStorage[key] = resolvedObject
            return DIContainerBuilder(container: self, object: object)
        }
        
        return DIContainerBuilder(container: self, object: object)
    }
    
    public func resolve<T>(tag: String? = "", bundle: Bundle? = nil) -> T {
        let key = DependencyKey(type: T.self, tag: tag)
        if let object = makeObject(for: key, bundle: bundle) {
            return object as! T
        } else {
            fatalError("Couldn't found object for type \(T.self)")
        }
    }
    
}

// MARK: - Private

private extension DIContainer {
    
    func makeObject(for key: DependencyKey, bundle: Bundle?, usingObject: DIObject? = nil) -> Any? {
        let object = usingObject ?? findObject(for: key, bundle: bundle)
        
        switch object.scope {
        case .single:
            return resolveStorage[key]
        case .prototype:
            return object.lazy.resolve()
        case .weak:
            if let weakReference = resolveStorage[key] as? WeakObject<AnyObject> {
                return weakReference.value
            }
            
            let resolvedObject = object.lazy.resolve() as AnyObject
            let weakObject = WeakObject(value: resolvedObject)
            resolveStorage[key] = weakObject
            return resolvedObject
        case .objectGraph:
            defer { objectGraphStackDepth -= 1 }
            
            if let object = resolveObjectGraphStorage[key] {
                if objectGraphStackDepth == 0 {
                    resolveObjectGraphStorage.removeAll()
                }
                return object
            }
            
            objectGraphStackDepth += 1
            let value = object.lazy.resolve() as Any
            resolveObjectGraphStorage[key] = value
            
            let mirror = Mirror(reflecting: value)
            
            for child in mirror.children {
                if let injectable = child.value as? InjectableProperty {
                    let subject = findObject(for: injectable.key, bundle: injectable.bundle)
                    if subject.scope != .single && subject.scope != .weak {
                        objectGraphStackDepth += 1
                        resolveObjectGraphStorage[subject.key] = self.makeObject(for: subject.key, bundle: subject.bundle, usingObject: subject)
                    }
                }
            }
            
            return value
        }
    }
    
    func findObject(for key: DependencyKey, bundle: Bundle?) -> DIObject {
        guard let object = containerStorage[key] else {
            fatalError("Can't found object for key \(key)")
        }
        
        if let bundle = bundle {
            if object.bundle != bundle {
                fatalError("Can't resolve object from passed bundle. Bundles are not equal")
            }
        }
        
        return object
    }
    
}

// MARK: Equatable

extension DIContainer: Equatable {
    
    public static func ==(lhs: DIContainer, rhs: DIContainer) -> Bool {
        return lhs.id == rhs.id
    }
    
}
