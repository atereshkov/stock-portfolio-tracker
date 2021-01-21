//
//  FeeRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Combine
import FirebaseFirestore

class FirebaseFeeRepository: FeeRepositoryType {
    
    let appState: Store<AppState>
    let db = Firestore.firestore()
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
}

extension FirebaseFeeRepository {
    
    func addFee(_ dto: AddFeeDTO, portfolioId: String?, tickerId: String?) -> Future<Void, Error> {
//        guard let userId = appState[\.user.id] else {
//            return Future { resolve in
//                resolve(.failure(.noUser))
//            }
//        }
        
        let userId = appState[\.user.id] ?? ""
        
        var data = dto.toDto()
        data["ownerUid"] = appState[\.user.id] ?? ""
        data["portfolioId"] = portfolioId
        data["tickerId"] = tickerId
        data["createdAt"] = Date().timeIntervalSince1970
        data["updatedAt"] = Date().timeIntervalSince1970
        
        return Future { [weak self] resolve in
            self?.db
                .collection("user_fees")
                .document(userId)
                .collection("fees")
                .addDocument(data: data) { error in
                    if let error = error {
                        resolve(.failure(error))
                    } else {
                        resolve(.success(()))
                    }
            }
        }
    }
    
}
