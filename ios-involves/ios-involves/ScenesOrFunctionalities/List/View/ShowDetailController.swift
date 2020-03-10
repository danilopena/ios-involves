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
    @IBOutlet private weak var name:              UILabel!
    @IBOutlet private weak var year:              UILabel!
    @IBOutlet private weak var numberOfSeasons:   UILabel!
    @IBOutlet private weak var percentageWatched: UILabel!
    @IBOutlet weak var seasonAndEpisodes: RoundedButton!
    @IBOutlet weak var separatorView:     UIView!
    
    /// Next/Last episode informations
    @IBOutlet weak var orientationEpisode: UILabel!
    @IBOutlet private weak var episodeTitle:       UILabel!
    @IBOutlet private weak var episodeDate:        UILabel!
    @IBOutlet private weak var episodeOverview:    UITextView!
    @IBOutlet private weak var episodeActivityIndicator: UIActivityIndicatorView!
    
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
                
        showDetailViewModel = ShowDetailViewModel(delegate: self, showDetailed: showToDetail)
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showDetailViewModel.fetchDetailShow(id: showToDetail.ids.trakt)
        showDetailViewModel.fetchNextEpisode(id: showToDetail.ids.trakt)
    }
    
    // -------------      -------------
    // MARK: Auxiliar Functions
    // -------------      -------------
    
    func setupLayout() {
        separatorView.backgroundColor = Color.purple
        orientationEpisode.textColor = Color.purple
        
        seasonAndEpisodes.setTitle(showDetailViewModel.seasonsAndEpisodesString, for: .normal)
    }
    
    /// This method will present general informations of the show 
    func setup() {
        navigationItem.title = showDetailViewModel.controllerTitleString
        // Show infos
        name.text = showDetailViewModel.showDetailNameString
        year.text = showDetailViewModel.showDetailYearString
        numberOfSeasons.text = showDetailViewModel.showDetailSeasonString
        percentageWatched.text = showDetailViewModel.showDetailWatchedString
    }
    
    /// This method will verify if has next episode. if true, will present the next episode if false, will present the last episode.
    func setupNextEpisodeOrLast() {
        //Next episode infos
        var episode: TraktEpisode!
        if showDetailViewModel.nextEpisode != nil {
            episode = showDetailViewModel.nextEpisode
            orientationEpisode.text = showDetailViewModel.nextEpisodeOrientationString
        } else if showDetailViewModel.lastEpisode != nil {
            episode = showDetailViewModel.lastEpisode
            orientationEpisode.text = showDetailViewModel.lastEpisodeOrientationString
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
