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
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String) -> Future<Void, Error> {
//        guard let userId = appState[\.user.id] else {
//            return Future { resolve in
//                resolve(.failure(.noUser))
//            }
//        }
        
        var data = dto.toDto()
        data["ownerUid"] = appState[\.user.id] ?? ""
        data["createdAt"] = Date().timeIntervalSince1970
        data["updatedAt"] = Date().timeIntervalSince1970
        
        return Future { [weak self] resolve in
            self?.db
                .collection("portfolio_dividends")
                .document(portfolioId)
                .collection("dividends")
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
