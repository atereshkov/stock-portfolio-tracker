//
//  FirebaseDividendRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import FirebaseFirestore

class FirebaseDividendRepository: DividendRepositoryType {
    
    let appState: Store<AppState>
    let db = Firestore.firestore()
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
}

extension FirebaseDividendRepository {
    
    func addDividend(_ dto: AddDividendDTO) -> Future<Void, Error> {
//        guard let userId = appState[\.user.id] else {
//            return Future { resolve in
//                resolve(.failure(.noUser))
//            }
//        }
        
        return Future { [weak self] resolve in
            var data = dto
            data.ownerUid = self?.appState[\.user.id] ?? ""
            self?.db.collection("dividend").addDocument(data: data.toDto()) { error in
                if let error = error {
                    resolve(.failure(error))
                } else {
                    resolve(.success(()))
                }
            }
        }
    }
    
}
