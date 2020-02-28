//
//  ShowDetailViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 28/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

protocol ShowDetailViewModelDelegate: class {
    func loaded(status: Status)
}

final class ShowDetailViewModel {

    private weak var delegate: ShowDetailViewModelDelegate?
    var show: TraktShowWatchedProgress!
    
    init(delegate: ShowDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchDetailShow(id: Int) {
        TraktManager.sharedManager.getShowWatchedProgress(showID: "\(id)") { [weak self] (result) in
            switch result {
                case .success(let result):
                    self?.show = result
                    self?.delegate?.loaded(status: .success)
                    break
                case .error(let error):
                    self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
                    break
            }
        }
    }
}
