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
        db.collection("user_portfolios")
            .document(userId)
            .collection("portfolios")
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let portfolios = documents
                        .compactMap { self?.toPortfolioViewItem($0, $0.data()) }
                    self?.session.appState[\.data.portfolios] = portfolios
                }
            }
    }
    
    private func toPortfolioViewItem(_ doc: QueryDocumentSnapshot, _ data: [String: Any]) -> PortfolioViewItem? {
        return PortfolioViewItem(
            id: doc.documentID,
            name: data["name"] as? String ?? "",
            currency: data["currency"] as? String ?? ""
        )
    }
    
}
