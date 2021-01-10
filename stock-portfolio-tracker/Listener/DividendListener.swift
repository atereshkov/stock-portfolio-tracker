//
//  DividendListener.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import DICE
import FirebaseFirestore

protocol DividendListenerType {
    
}

class DividendListener: DividendListenerType {
    
    let session: SessionType
    let db = Firestore.firestore()
    
    private var cancelBag = CancelBag()
    
    init(session: SessionType) {
        self.session = session
        
        session.appState.map(\.user.id)
            .removeDuplicates()
            .sink { [weak self] id in
                guard let id = id else { return }
                self?.listenDividendChanges(userId: id)
            }
            .store(in: cancelBag)
    }
    
}

private extension DividendListener {
    
    private func listenDividendChanges(userId: String) {
        db.collection("dividend")
            .whereField("ownerUid", isEqualTo: userId)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let dividends = documents
                        .map { DividendViewItem(
                            id: $0.documentID,
                            ownerId: $0.data()["ownerUid"] as? String ?? "",
                            portfolioId: $0.data()["portfolioId"] as? String ?? "",
                            ticker: $0.data()["ticker"] as? String ?? "",
                            date: $0.data()["date"] as? Date ?? Date(),
                            paid: $0.data()["paid"] as? Float ?? 0.0,
                            tax: $0.data()["tax"] as? Double ?? 0.0)
                        }
                    self?.session.appState[\.data.dividends] = dividends
                }
            }
    }
    
}
