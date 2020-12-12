# DICE

[![CI Status](https://img.shields.io/travis/dice-swift/DICE.svg?style=flat)](https://travis-ci.org/github/DICE-Swift/dice)
[![codecov](https://codecov.io/gh/DICE-Swift/dice/branch/master/graph/badge.svg)](https://codecov.io/gh/DICE-Swift/dice)
[![Version](https://img.shields.io/cocoapods/v/DICE.svg?style=flat)](https://cocoapods.org/pods/DICE)
[![License](https://img.shields.io/cocoapods/l/DICE.svg?style=flat)](https://cocoapods.org/pods/DICE)
[![Platform](https://img.shields.io/cocoapods/p/DICE.svg?style=flat)](https://cocoapods.org/pods/DICE)

DICE is a lightweight Swift framework that provides property based dependency injection for Swift and SwiftUI projects.
DICE also provides service locator pattern with the help of containers. Easily inject your dependencies through property wrappers or through DI container.
DICE supports different [scopes](https://github.com/DICE-Swift/dice#scopes) (singleton, lazy weak, lazy prototype, lazy object graph).

## Requirements

* Swift 5.1
* iOS 13.0

## Installation

DICE is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DICE'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

## Inject through DI container

**1. Add import**

```swift
import DICE
```

**2. Declare your container**

```swift
let container = DIContainer()
```

**3. Register your instances**

```swift
container.register(DummyServiceType.self) { _ in
    return DummyService()
}
```

E.g. DummyServiceType is just a protocol and DummyService is an implementation.

```swift
protocol DummyServiceType {
    func test()
}

class DummyService: DummyServiceType {
    func test() {
        Swift.print("DummyService")
    }
}
```

**4. Pass container to DICE**

```swift
DICE.use(container)
```

**5. Resolve instance**

**Using DIContainer**

```swift
import UIKit
import DICE

class ViewController: UIViewController {
    let container = DIContainer()
    // In real case you'll need to pass container in ViewController or another class and all the dependencies should have been already registered prior to using container
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.register(DummyServiceType.self, scope: .single) { _ in
            return DummyService()
        }
        
        DICE.use(container)
        
        let service: DummyServiceType = container.resolve()
        service.test()
        
        // It should print "DummyService" in Xcode console
        // If you get error here, so check previous steps or open an issue
    }
}
```

**Using @Injected Property Wrapper**

```swift
import UIKit
import DICE

class ViewController: UIViewController {
    @Injected var dummyService: DummyServiceType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dummyService.test()
        // It should print "DummyService" in Xcode console
        // If you get error here, so check previous steps or open an issue
    }
}
```

## Inject in SwiftUI

### EnvironmentObservableInjected

Dynamic view property wrapper that subscribes to a `ObservableObject` automatically invalidating the view when it changes.

```swift
struct ContentView: View {
    @EnvironmentObservableInjected var viewModel: ContentViewModel

    var body: some View {
        HStack {
            Text(viewModel.title)
        }.onAppear { self.viewModel.startUpdatingTitle() }
    }
}

...

class ContentViewModel: ObservableObject {
    @Published private(set) var title: String = ""
    
    func startUpdatingTitle() {
        self.title = "Test"
    }
}
```

### EnvironmentInjected

Property wrapper that inject object from environment container. Read only object. Typically used for non-mutating objects.

```swift
struct ContentView: View {
    @EnvironmentInjected var service: WebService

    var body: some View {
        HStack {
            Text("Waiting...")
        }.onAppear { self.service.auth() }
    }
}

```

## Advanced usage

## Scopes

### Default scope

Default scope is `DIScope.objectGraph`. All registered objects will use default scope if no scope set when registering.
It can be changed by setting `DICE.Defaults.scope`, for example:

```swift
DICE.Defaults.scope = .single
```

### Supported scopes

* `DIScope.single`

Dependency is created per container as single instance.
Recommended to use for singletones that should be instantiated as soon as injected in the `DIContainer`.

* `DIScope.weak`

Dependency is lazily created one per container, but destroys when dependency object will deinit.
Object will be instantiated only after first call.

* `DIScope.prototype`

Dependency instance is lazily created each time.
Object will be instantiated only after first call.

* `DIScope.objectGraph`

Dependency instance is lazily created one per object graph.
Object will be instantiated only after first call.

### Set scope

You can specify scopy by using optional `scope` parameter when registering an object. If no scope passed then default scope `DIScope.Defaults.scope` is used.

```swift
container.register(InjectableServiceType.self, scope: .objectGraph) { _ in
    return InjectableService()
}
```

## Using container resolver when injecting

Let's say `InjectableService` requires to recieve `InternalServiceType` in the initializer as a dependency.

```swift
class InjectableService: InjectableServiceType {
    let internalService: InternalServiceType
    
    init(internalService: InternalServiceType) {
        self.internalService = internalService
    }
}
```

1. Register `InternalServiceType`

```swift
container.register(InternalServiceType.self) { _ in
    return InternalService()
}
```

2. Resolve `InternalServiceType` from container when registering `InjectableServiceType` and pass it to the `InjectableService`

```swift
container.register(InjectableServiceType.self) { container in
    let internalService: InternalServiceType = container.resolve()
    return InjectableService(internalService: internalService)
}
```

## Tags

When you registering dependencies you could assign a tag for an object. When you resolve dependencies either using `DIContainer.resolve()` or property wrappeprs `Injected`, `EnvironmentObservableInjected`, `EnvironmentInjected` use a tag to inject an object that matches the tag you passed.

### Register dependency with a tag

```swift
container.register(InternalServiceType.self, tag: "dependency1") { _ in
    return InternalService(test: "stringInternal")
}
```

### Resolve dependency with a tag

Let's say we want to inject `InternalService` with the type `InternalServiceType` and tag `dependency1`, as per our example above.

1. Resolve using `DIContainer.resolve()`

```swift
let service: InternalServiceType = container.resolve(tag: "dependency1")
```

2. Resolve using property wrappers

```swift
@Injected("dependency1") var service: InternalServiceType
```


## Versioning

Version numbering follows the [Semantic versioning](https://semver.org/) approach.

## Communication and Help

* If you need help, use [Stack Overflow](http://stackoverflow.com/questions/tagged/dice) (Tag 'dice') or [open an issue](https://github.com/dice-swift/dice/issues/new).
* If you'd like to ask a general question, use [Stack Overflow](http://stackoverflow.com/questions/tagged/dice) or [open an issue](https://github.com/dice-swift/dice/issues/new).
* If you've found a bug, [open an issue](https://github.com/dice-swift/dice/issues/new).
* If you have a feature request, [open an issue](https://github.com/dice-swift/dice/issues/new).
* If you want to contribute, submit a [pull request](https://github.com/dice-swift/dice/pulls).
* If you use and enjoy DICE, please star the [project on GitHub](https://github.com/dice-swift/dice).

## Contributing

We’re really happy to accept contributions from the community, that’s the main reason why we open-sourced it!

1. Fork it (https://github.com/DICE-Swift/dice/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new [Pull Request](https://github.com/DICE-Swift/dice/pulls)

## Contributors

### Maintainers

* Alexander Tereshkov | [Github](https://github.com/atereshkov) | [Website](https://tereshkov.pw/)
* Anton Paliakou | [Github](https://github.com/Toni77777) | [Blog](https://tonidevblog.com/)

### Contributors

Want to be a first contributor? Please, suggest your improvements by using [Contributing](https://github.com/DICE-Swift/dice#contributing) section.

## License

DICE is available under the MIT license. See the LICENSE file for more info.
