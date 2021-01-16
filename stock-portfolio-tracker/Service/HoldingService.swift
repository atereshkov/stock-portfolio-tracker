//
//  HoldingService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import DICE
import Combine

protocol HoldingServiceType {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error>
    
    func loadLots(portfolioId: String, holdingId: String) -> Future<Void, Error>
    
    func addLot(lot: AddLotDTO, portfolioId: String, holdingId: String) -> Future<Void, Error>
    
}

class HoldingService: HoldingServiceType {
    
    @Injected var holdingRepository: HoldingRepositoryType
    
    let session: SessionType
    
    init(session: SessionType) {
        self.session = session
    }
    
    private let cancelBag = CancelBag()
    
}

extension HoldingService {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error> {
        return holdingRepository.addHolding(holding: holding, portfolioId: portfolioId)
    }
    
    func loadLots(portfolioId: String, holdingId: String) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] resolve in
            guard let sself = self else { return }
            self?.holdingRepository.loadLots(portfolioId: portfolioId, holdingId: holdingId).sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    resolve(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] lots in
                let viewItems = lots.compactMap { LotViewItem.from($0) }
                self?.session.appState[\.data.lots][holdingId] = viewItems
                resolve(.success(()))
            })
            .store(in: sself.cancelBag)
        }
    }
    
    func addLot(lot: AddLotDTO, portfolioId: String, holdingId: String) -> Future<Void, Error> {
        return holdingRepository.addLot(lot: lot, portfolioId: portfolioId, holdingId: holdingId)
    }
    
}
