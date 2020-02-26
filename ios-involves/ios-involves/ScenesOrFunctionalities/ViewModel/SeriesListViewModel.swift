//
//  SeriesListViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 23/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

protocol SeriesListViewModelDelegate: class {
    func loaded(state: State)
}

final class SeriesListViewModel {
    private weak var delegate: SeriesListViewModelDelegate?
    var lists: [TraktList]?
    
    init(delegate: SeriesListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchLists() {
        TraktManager.sharedManager.getCustomLists() { [weak self] result in
            switch result {
            case .success(let lists):
                self?.lists = lists
                self?.delegate?.loaded(state: .success)
            case .error(let error):
                self?.delegate?.loaded(state: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
            }
        }
    }
}
