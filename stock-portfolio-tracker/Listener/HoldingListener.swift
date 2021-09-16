//
//  HoldingListener.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import DICE
import FirebaseFirestore

protocol HoldingListenerType {
    
}

class HoldingListener: HoldingListenerType {
    
    let session: SessionType
    let db = Firestore.firestore()
    
    private var cancelBag = CancelBag()
    
    init(session: SessionType) {
        self.session = session
        
        session.appState.map(\.user.id)
            .removeDuplicates()
            .sink { [weak self] id in
                guard let id = id else { return }
                self?.listenHoldingChanges(userId: id)
            }
            .store(in: cancelBag)
    }
    
}

private extension HoldingListener {
    
    private func listenHoldingChanges(userId: String) {
        db.collectionGroup("holdings")
            .whereField("ownerUid", isEqualTo: userId)
            .order(by: "updatedAt", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let holdings = documents
                        .compactMap { self?.toHoldingItem($0, $0.data()) }
                    self?.session.appState[\.data.holdings] = holdings
                }
            }
    }
    
    private func toHoldingItem(_ doc: QueryDocumentSnapshot, _ data: [String: Any]) -> HoldingViewItem? {
        let dto = HoldingDTO.from(data)
        return HoldingViewItem.from(dto)
    }
    
}
