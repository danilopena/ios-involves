//
//  ShowSeasonsAndEpisodesViewModel.swift
//  ios-involves
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class ShowSeasonsAndEpisodesViewModel: NSObject {

    var showProgress: TraktShowWatchedProgress!
    var show: TraktShow!
    var delegate: StatusDelegate!

    init(delegate: StatusDelegate, show: TraktShow? = nil, showProgress: TraktShowWatchedProgress? = nil) {
        self.delegate = delegate
        self.showProgress = showProgress
        self.show = show
    }
    
    func watch(episodeNumber: Int, seasonNumber: Int) {
        /// First we need episode summary to pass him in addToHistory.
        TraktManager.sharedManager.getEpisodeSummary(
                                        showID: "\(show.ids.trakt)",
                                        seasonNumber: NSNumber(value: seasonNumber),
                                        episodeNumber: NSNumber(value: episodeNumber))
        { [weak self] (result) in
            switch result {
                case .success(let episode):
                    do {
                        try TraktManager.sharedManager.addToHistory(movies: [], shows: [], episodes: [episode.asDictionary()]) { [weak self] (result) in
                            switch result {
                                case .success:
                                    self?.delegate?.loaded(status: .success)
                                    break
                                case .fail:                self?.delegate?.loaded(status: .failed(error: "Failed to watch"))
                                    break
                            }
                        }
                    }
                    catch {
                        self?.delegate?.loaded(status: .failed(error: "Failed to watch"))
                    }
                case .error(let error):
                    self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
                    break
            }
        }
    }
    
    func fetchDetailShow(id: Int) {
        TraktManager.sharedManager.getShowWatchedProgress(showID: "\(id)") { [weak self] (result) in
            switch result {
                case .success(let result):
                    self?.showProgress = result
                    self?.delegate?.loaded(status: .success)
                    break
                case .error(let error):
                    self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
                    break
            }
        }
    }
}

extension ShowSeasonsAndEpisodesViewModel {
    enum Localizable {
        static let controllerTitle   = "seasonsAndEpisodes.title"
        static let season            = "seasonsAndEpisodes.season"
    }
    
    var controllerTitleString: String {
        return Localizable.controllerTitle.localized
    }
    
    var seasonString: String {
        return Localizable.season.localized
    }
}
