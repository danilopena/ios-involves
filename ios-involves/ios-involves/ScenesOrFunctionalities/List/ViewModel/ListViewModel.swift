//
//  SeriesListViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 23/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

protocol ListViewModelDelegate: class {
    func loaded(status: Status)
}

final class ListViewModel {
    
    private weak var delegate: ListViewModelDelegate?
    var lists: [TraktList]?
    
    init(delegate: ListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchLists() {
        TraktManager.sharedManager.getCustomLists() { [weak self] result in
            switch result {
            case .success(let lists):
                self?.lists = lists
                self?.delegate?.loaded(status: .success)
            case .error(let error):
                self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
            }
        }
    }
}
