//
//  ListDetailViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 26/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

protocol ListDetailViewModelDelegate: class {
    func loaded(state: State)
}

final class ListDetailViewModel {

    private weak var delegate: ListDetailViewModelDelegate?
    var items: [TraktListItem]?
    
    init(delegate: ListDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchListDetail(list: TraktList) {
        TraktManager.sharedManager.getItemsForCustomList(listID: "\(list.ids.trakt)") { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                self?.delegate?.loaded(state: .success)
            case .error(let error):
                self?.delegate?.loaded(state: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
            }
        }
    }
}
