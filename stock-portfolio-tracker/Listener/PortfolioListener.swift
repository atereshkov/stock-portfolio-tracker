//
//  PortfolioListener.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import DICE
import FirebaseFirestore

protocol PortfolioListenerType {
    
}

class PortfolioListener: PortfolioListenerType {
    
    let session: SessionType
    let db = Firestore.firestore()
    
    private var cancelBag = CancelBag()
    
    init(session: SessionType) {
        self.session = session
        
        session.appState.map(\.user.id)
            .removeDuplicates()
            .sink { [weak self] id in
                guard let id = id else { return }
                self?.listenPortfolioChanges(userId: id)
            }
            .store(in: cancelBag)
    }
    
}

private extension PortfolioListener {
    
    private func listenPortfolioChanges(userId: String) {
        db.collection("portfolio")
            .whereField("ownerUid", isEqualTo: userId)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let portfolios = documents
                        .map { PortfolioViewItem(
                            id: $0.documentID,
                            name: $0.data()["name"] as? String ?? "",
                            currency: $0.data()["currency"] as? String ?? "")
                        }
                    self?.session.appState[\.data.portfolios] = portfolios
                }
            }
    }
    
}
