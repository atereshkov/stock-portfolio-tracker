//
//  FirebaseHoldingRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Combine
import FirebaseFirestore

class FirebaseHoldingRepository: HoldingRepositoryType {
    
    let appState: Store<AppState>
    let db = Firestore.firestore()
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
}

extension FirebaseHoldingRepository {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error> {
        let userId = appState[\.user.id] ?? ""
        
        var data = holding.toDto()
        data["ownerUid"] = userId
        data["createdAt"] = Date().timeIntervalSince1970
        data["updatedAt"] = Date().timeIntervalSince1970
        
        return Future { [weak self] resolve in
            self?.db
                .collection("portfolio_holdings")
                .document(portfolioId)
                .collection("holdings")
                .document(holding.id)
                .setData(data, merge: true) { error in
                    if let error = error {
                        resolve(.failure(error))
                    } else {
                        resolve(.success(()))
                    }
            }
        }
    }
    
    func loadLots(portfolioId: String, holdingId: String) -> Future<[LotDTO], Error> {
        let userId = appState[\.user.id] ?? ""
        
        return Future { [weak self] resolve in
            self?.db.collection("portfolio_holding_lots")
                .document(portfolioId)
                .collection("holdings")
                .document(holdingId)
                .collection("lots")
                .whereField("ownerUid", isEqualTo: userId)
                .order(by: "updatedAt", descending: true)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        resolve(.failure(error))
                    } else if let documents = querySnapshot?.documents {
                        let lots = documents
                            .compactMap { LotDTO.from(id: $0.documentID, data: $0.data()) }
                        resolve(.success(lots))
                    }
                }
        }
    }
    
    func addLot(lot: AddLotDTO, portfolioId: String, holdingId: String) -> Future<Void, Error> {
        var data = lot.toDto()
        data["ownerUid"] = appState[\.user.id] ?? ""
        data["holdingId"] = holdingId
        data["createdAt"] = Date().timeIntervalSince1970
        data["updatedAt"] = Date().timeIntervalSince1970
        
        return Future { [weak self] resolve in
            self?.db
                .collection("portfolio_holding_lots")
                .document(portfolioId)
                .collection("holdings")
                .document(holdingId)
                .collection("lots")
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
