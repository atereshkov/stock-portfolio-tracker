//
//  FirebasePortfolioRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import FirebaseFirestore

class FirebasePortfolioRepository: PortfolioRepositoryType {
    
    let appState: Store<AppState>
    let db = Firestore.firestore()
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
}

extension FirebasePortfolioRepository {
    
    func createPortfolio(name: String, currency: String) -> Future<Void, Error> {
//        guard let userId = appState[\.user.id] else {
//            return Future { resolve in
//                resolve(.failure(.noUser))
//            }
//        }
        
        let data = [
            "name": name,
            "currency": currency
        ]
        
        let userId = appState[\.user.id] ?? ""
        
        return Future { [weak self] resolve in
            self?.db
                .collection("user_portfolios")
                .document(userId)
                .collection("portfolios")
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
