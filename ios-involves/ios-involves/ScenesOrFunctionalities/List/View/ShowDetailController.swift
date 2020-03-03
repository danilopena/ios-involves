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

    // -------------      -------------
    // MARK: IBOutlets
    // -------------      -------------
    
    /// General informations
    @IBOutlet weak var name:              UILabel!
    @IBOutlet weak var year:              UILabel!
    @IBOutlet weak var numberOfSeasons:   UILabel!
    @IBOutlet weak var percentageWatched: UILabel!
    @IBOutlet weak var seasonAndEpisodes: RoundedButton! {
        didSet {
            seasonAndEpisodes.setTitle(Localizable.seasonsAndEpisodes.localized, for: .normal)
        }
    }
    @IBOutlet weak var separatorView:     UIView!
    
    /// Next/Last episode informations
    @IBOutlet weak var orientationEpisode: UILabel!
    @IBOutlet weak var episodeTitle:       UILabel!
    @IBOutlet weak var episodeDate:        UILabel!
    @IBOutlet weak var episodeOverview:    UITextView!
    @IBOutlet weak var episodeActivityIndicator: UIActivityIndicatorView!
    
    // -------------      -------------
    // MARK: Variables
    // -------------      -------------
    
    private var showDetailViewModel: ShowDetailViewModel!
    var showToDetail: TraktShow!

    // -------------      -------------
    // MARK: Native Functions
    // -------------      -------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        showDetailViewModel = ShowDetailViewModel(delegate: self)
        showDetailViewModel.fetchDetailShow(id: showToDetail.ids.trakt)
        showDetailViewModel.fetchNextEpisode(id: showToDetail.ids.trakt)
    }
    
    // -------------      -------------
    // MARK: Auxiliar Functions
    // -------------      -------------
    
    /// This method will present general informations of the show 
    func setup() {
        navigationItem.title = Localizable.controllerTitle.localized
        separatorView.backgroundColor = Color.purple
        orientationEpisode.textColor = Color.purple
        
        // Show infos
        name.text = Localizable.showDetailName.localized + showToDetail.title
        year.text = Localizable.showDetailYear.localized + "\(showToDetail.year ?? 0)"
        numberOfSeasons.text = "\(showDetailViewModel.show.seasons.count)" + Localizable.showDetailSeason.localized
        
        percentageWatched.text = showDetailViewModel.makePercentageWatchedCalc() + Localizable.showDetailWatched.localized
    }
    
    /// This method will verify if has next episode. if true, will present the next episode if false, will present the last episode.
    func setupNextEpisodeOrLast() {
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
        episodeDate.text = showDetailViewModel.getAiredDateFormated(episode: episode)
        episodeOverview.text = episode.overview
        episodeActivityIndicator.stopAnimating()
    }
    
    // -------------      -------------
    // MARK: IBActions
    // -------------      -------------
    
    @IBAction func showSeasonsAndEpisodes() {
        showDetailViewModel.fetchDetailForListSeasonsAndEpisodes(id: showToDetail.ids.trakt)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.sendToSeasonsAndEpisodes {
            let destination = segue.destination as? ShowSeasonsAndEpisodesController
            destination?.showProgress = showDetailViewModel.show
            destination?.showToDetail = showToDetail
        }
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
        static let seasonsAndEpisodes = "list.detail.seasonsAndEpisodes"
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
                    self.setupNextEpisodeOrLast()
                }
                break
            case .failed(let error):
                alert(message: error, completion: {})
        }
    }
    
    func loadedShowForSeasonsAndEpisodes(status: Status) {
        switch status {
        case .success:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: SegueIdentifier.sendToSeasonsAndEpisodes, sender: self)
            }
        case .failed(let error):
            alert(message: error, completion: {})
        }
    }
}
