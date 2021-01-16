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
    
}

private extension FirebaseHoldingRepository {
    
    private func toItem(_ doc: QueryDocumentSnapshot, _ data: [String: Any]) -> HoldingViewItem? {
        let dto = HoldingDTO.from(data)
        return HoldingViewItem.from(dto)
    }
    
}
