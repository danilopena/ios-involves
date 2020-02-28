//
//  WatchingSeriesViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 26/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import Foundation
import TraktKit

protocol WatchingSeriesViewModelDelegate: class {
    func loaded(status: Status)
}

final class WatchingSeriesViewModel {

    private weak var delegate: WatchingSeriesViewModelDelegate?
    var watching: TraktWatching?
    
    init(delegate: WatchingSeriesViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchWatching() {
        TraktManager.sharedManager.getUserWatching() { [weak self] result in
            switch result {
            case .notCheckedIn:
                self?.delegate?.loaded(status: .success)
                break
            case .checkedIn(let watching):
                self?.watching = watching
                self?.delegate?.loaded(status: .success)
            case .error(let error):
                self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
            }
        }
    }
}
