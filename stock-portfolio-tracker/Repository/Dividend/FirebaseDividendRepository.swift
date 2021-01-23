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
    
    func loadDividends(limit: Int) -> Future<[DividendDTO], Error> {
        let userId = appState[\.user.id] ?? ""
        
        return Future { [weak self] resolve in
            self?.db
                .collectionGroup("dividends")
                .whereField("ownerUid", isEqualTo: userId)
                .order(by: "createdAt", descending: true)
                .limit(to: 10)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        resolve(.failure(error))
                    } else if let documents = querySnapshot?.documents {
                        let dividends = documents
                            .compactMap { DividendDTO.from(id: $0.documentID, data: $0.data()) }
                        resolve(.success((dividends)))
                    }
                }
        }
    }
    
    func loadPagedDividends(limit: Int, lastItem: DividendViewItem) -> Future<[DividendDTO], Error> {
        let userId = appState[\.user.id] ?? ""
        
        return Future { [weak self] resolve in
            self?.db
                .collectionGroup("dividends")
                .whereField("ownerUid", isEqualTo: userId)
                .order(by: "createdAt", descending: true)
                .start(after: [lastItem.createdAt.timeIntervalSince1970])
                .limit(to: limit)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        resolve(.failure(error))
                    } else if let documents = querySnapshot?.documents {
                        let dividends = documents
                            .compactMap { DividendDTO.from(id: $0.documentID, data: $0.data()) }
                        resolve(.success(dividends))
                    }
                }
        }
    }
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String) -> Future<Void, Error> {
//        guard let userId = appState[\.user.id] else {
//            return Future { resolve in
//                resolve(.failure(.noUser))
//            }
//        }
        
        var data = dto.toDto()
        data["ownerUid"] = appState[\.user.id] ?? ""
        data["portfolioId"] = portfolioId
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
