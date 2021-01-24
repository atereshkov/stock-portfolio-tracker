//
//  DividendService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import DICE
import Combine

protocol DividendServiceType {
    
    func loadDividends(limit: Int) -> Future<Void, Error>
    
    func loadPagedDividends(limit: Int, lastItem: DividendViewItem) -> Future<Void, Error>
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String?) -> Future<Void, Error>
    
}

class DividendService: DividendServiceType {
    
    @Injected var dividendRepository: DividendRepositoryType
    
    let session: SessionType
    
    init(session: SessionType) {
        self.session = session
    }
    
    private let cancelBag = CancelBag()
    
}

extension DividendService {
    
    func loadDividends(limit: Int) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] resolve in
            guard let sself = self else { return }
            self?.dividendRepository.loadDividends(limit: limit).sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    resolve(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] dividends in
                let viewItems = dividends.compactMap { DividendViewItem.from($0) }
                self?.session.appState[\.data.dividends] = viewItems
                resolve(.success(()))
            })
            .store(in: sself.cancelBag)
        }
    }
    
    func loadPagedDividends(limit: Int, lastItem: DividendViewItem) -> Future<Void, Error> {
        return Future<Void, Error> { [weak self] resolve in
            guard let sself = self else { return }
            self?.dividendRepository.loadPagedDividends(limit: limit, lastItem: lastItem).sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    resolve(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] dividends in
                let viewItems = dividends.compactMap { DividendViewItem.from($0) }
                let currentDividends = self?.session.appState[\.data.dividends] ?? []
                for item in viewItems {
                    if !currentDividends.contains(item) {
                        self?.session.appState[\.data.dividends].append(item)
                    }
                }
                self?.session.appState[\.data.dividends].sort(by: { $0.createdAt > $1.createdAt })
                resolve(.success(()))
            })
            .store(in: sself.cancelBag)
        }
    }
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String?) -> Future<Void, Error> {
        return dividendRepository.addDividend(dto, portfolioId: portfolioId)
    }
    
}
