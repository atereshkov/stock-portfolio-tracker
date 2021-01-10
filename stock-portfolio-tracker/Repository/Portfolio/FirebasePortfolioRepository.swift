//
//  FirebasePortfolioRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import FirebaseFirestore

class FirebasePortfolioRepository: PortfolioRepositoryType {
    
    let db = Firestore.firestore()
    
    func createPortfolio(name: String, currency: String) -> Future<Void, Error> {
        return Future { [weak self] resolve in
            self?.db.collection("portfolio").addDocument(data: [
                "name": name,
                "currency": currency
            ]) { error in
                if let error = error {
                    resolve(.failure(error))
                } else {
                    resolve(.success(()))
                }
            }
        }
    }
    
}
