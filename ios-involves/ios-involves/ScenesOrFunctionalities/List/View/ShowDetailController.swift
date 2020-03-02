//
//  ShowDetailController.swift
//  ios-involves
//
//  Created by Danilo Pena on 28/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class ShowDetailController: UIViewController {

    @IBOutlet weak var name:              UILabel!
    @IBOutlet weak var year:              UILabel!
    @IBOutlet weak var numberOfSeasons:   UILabel!
    @IBOutlet weak var percentageWatched: UILabel!
    
    @IBOutlet weak var orientationEpisode: UILabel!
    @IBOutlet weak var episodeTitle:       UILabel!
    @IBOutlet weak var episodeDate:        UILabel!
    @IBOutlet weak var episodeOverview:    UITextView!
    @IBOutlet weak var episodeActivityIndicator: UIActivityIndicatorView!
    
    private var showDetailViewModel: ShowDetailViewModel!
    var showToDetail: TraktShow!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDetailViewModel = ShowDetailViewModel(delegate: self)
        showDetailViewModel.fetchDetailShow(id: showToDetail.ids.trakt)
        showDetailViewModel.fetchNextEpisode(id: showToDetail.ids.trakt)
    }
    
    func setup() {
        navigationItem.title = Localizable.controllerTitle.localized
        
        // Show infos
        name.text = Localizable.showDetailName.localized + showToDetail.title
        year.text = Localizable.showDetailYear.localized + "\(showToDetail.year ?? 0)"
        numberOfSeasons.text = "\(showDetailViewModel.show.seasons.count)" + Localizable.showDetailSeason.localized
        percentageWatched.text = showDetailViewModel.makePercentageWatchedCalc() + Localizable.showDetailWatched.localized
    }
    
    func setupNextEpisode() {
        //Next episode infos
        var episode: TraktEpisode!
        if showDetailViewModel.nextEpisode != nil {
            episode = showDetailViewModel.nextEpisode
            orientationEpisode.text = Localizable.nextEpisodeOrientation.localized
        } else if showDetailViewModel.lastEpisode != nil {
            episode = showDetailViewModel.lastEpisode
            orientationEpisode.text = Localizable.lastEpisodeOrientation.localized
        }
        
        episodeTitle.text = episode.title
        
        //Colocar a data formatada
        episodeDate.text = "\(episode.firstAired)"
        episodeOverview.text = episode.overview
        episodeActivityIndicator.stopAnimating()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension ShowDetailController {
    private enum Localizable {
        static let controllerTitle    = "show.title"
        static let showDetailName     = "list.detail.name"
        static let showDetailYear     = "list.detail.year"
        static let showDetailSeason   = "show.detail.season"
        static let showDetailWatched  = "show.detail.watched"
        static let nextEpisodeOrientation = "show.detail.nextEpisodeOrientation"
        static let lastEpisodeOrientation = "show.detail.lastEpisodeOrientation"

    }
}

extension ShowDetailController: ShowDetailViewModelDelegate {
    func loaded(status: Status) {
        switch status {
            case .success:
                DispatchQueue.main.async {
                    self.setup()
                }
                break
            case .failed(let error):
                alert(message: error, completion: {})
        }
    }
    
    func loadedNextEpisode(status: Status) {
        switch status {
            case .success:
                DispatchQueue.main.async {
                    self.setupNextEpisode()
                }
                break
            case .failed(let error):
                alert(message: error, completion: {})
        }
    }
}
