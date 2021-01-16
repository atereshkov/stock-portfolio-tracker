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
        db.collectionGroup("dividends")
            .whereField("ownerUid", isEqualTo: userId)
            .order(by: "updatedAt", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let dividends = documents.compactMap { self?.toDividendViewItem($0, $0.data()) }
                    self?.session.appState[\.data.dividends] = dividends
                }
            }
    }
    
    func toDividendViewItem(_ doc: QueryDocumentSnapshot, _ data: [String: Any]) -> DividendViewItem? {
        guard let paidData = data["paid"] as? [String: Any] else { return nil }
        let paidDto = MoneyDTO.from(paidData)
        let paidViewItem = MoneyViewItem.from(paidDto)
        
        return DividendViewItem(
            id: doc.documentID,
            portfolioId: data["portfolioId"] as? String ?? "",
            ticker: data["ticker"] as? String ?? "",
            date: data["date"] as? Date ?? Date(),
            paid: paidViewItem,
            tax: data["tax"] as? Double ?? 0.0)
    }
    
}
