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
    func loadedNextEpisode(status: Status)
    func loadedShowForSeasonsAndEpisodes(status: Status)
}

final class ShowDetailViewModel {

    private weak var delegate: ShowDetailViewModelDelegate?
    var show:        TraktShowWatchedProgress!
    var showToDetail: TraktShow!
    var nextEpisode: TraktEpisode!
    var lastEpisode: TraktEpisode!
    let dateFormatString = "dd/MM/yyyy HH:mm:ss"

    init(delegate: ShowDetailViewModelDelegate, showDetailed: TraktShow? = nil) {
        self.delegate = delegate
        self.showToDetail = showDetailed
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
    
    func fetchDetailForListSeasonsAndEpisodes(id: Int) {
        TraktManager.sharedManager.getShowWatchedProgress(showID: "\(id)") { [weak self] (result) in
            switch result {
                case .success(let result):
                    self?.show = result
                    self?.delegate?.loadedShowForSeasonsAndEpisodes(status: .success)
                case .error(let error):
                    self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
                    break
            }
        }
    }
    
    func fetchNextEpisode(id: Int) {
        TraktManager.sharedManager.getNextEpisode(showID: "\(id)", extended: [ExtendedType.Full]) { [weak self] (result) in
            switch result {
                case .success(let result):
                    self?.nextEpisode = result
                    self?.delegate?.loadedNextEpisode(status: .success)
                    break
                case .error( _):
                    TraktManager.sharedManager.getLastEpisode(showID: "\(id)", extended: [ExtendedType.Full]) { (result) in
                        switch result {
                            case .success(let result):
                                self?.lastEpisode = result
                                self?.delegate?.loadedNextEpisode(status: .success)
                                break
                            case .error(let error):
                                self?.delegate?.loaded(status: .failed(error: "Failed to get your lists profile: \(String(describing: error?.localizedDescription))"))
                                break
                        }
                    }
                    break
            }
        }
    }
    
    private func makePercentageWatchedCalc() -> String {
        return "\((show.completed * 100) / show.aired)" + "%"
    }
    
    func getAiredDateFormated(episode: TraktEpisode) -> String {
        guard let date = episode.firstAired else {
            return ""
        }

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = dateFormatString

        return dateFormatterPrint.string(from: date)
    }
}

extension ShowDetailViewModel {
    enum Localizable {
        static let controllerTitle    = "show.title"
        static let showDetailName     = "list.detail.name"
        static let showDetailYear     = "list.detail.year"
        static let showDetailSeason   = "show.detail.season"
        static let showDetailWatched  = "show.detail.watched"
        static let nextEpisodeOrientation = "show.detail.nextEpisodeOrientation"
        static let lastEpisodeOrientation = "show.detail.lastEpisodeOrientation"
        static let seasonsAndEpisodes = "list.detail.seasonsAndEpisodes"
    }
    
    var controllerTitleString: String {
        return Localizable.controllerTitle.localized
    }
    
    var showDetailNameString: String {
        return Localizable.showDetailName.localized + showToDetail.title
    }
    
    var showDetailYearString: String {
        return Localizable.showDetailYear.localized + "\(showToDetail.year ?? 0)"
    }
    
    var showDetailSeasonString: String {
        return "\(show.seasons.count)" +  Localizable.showDetailSeason.localized
    }
    
    var showDetailWatchedString: String {
        return makePercentageWatchedCalc() + Localizable.showDetailWatched.localized
    }
    
    var nextEpisodeOrientationString: String {
        return Localizable.nextEpisodeOrientation.localized
    }
    
    var lastEpisodeOrientationString: String {
        return Localizable.lastEpisodeOrientation.localized
    }
    
    var seasonsAndEpisodesString: String {
        return Localizable.seasonsAndEpisodes.localized
    }
}
