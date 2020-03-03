//
//  ShowSeasonsAndEpisodesController.swift
//  ios-involves
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

protocol ShowSeasonsAndEpisodesControllerDelegate {
    func atualizeShowProgressStatus()
    func presentError(error: String)
}

class ShowSeasonsAndEpisodesController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var showToDetail: TraktShow!
    var showProgress: TraktShowWatchedProgress!
    var showSeasonsAndEpisodesViewModel: ShowSeasonsAndEpisodesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        showSeasonsAndEpisodesViewModel = ShowSeasonsAndEpisodesViewModel(delegate: self)
    }
    
    func setup() {
        navigationItem.title = Localizable.controllerTitle.localized
    }
}

extension ShowSeasonsAndEpisodesController {
    private enum Constants {
        static let cellIdentifier = "episodeCell"
    }
    
    private enum Localizable {
        static let controllerTitle   = "seasonsAndEpisodes.title"
        static let season            = "seasonsAndEpisodes.season"
    }
}


extension ShowSeasonsAndEpisodesController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return showProgress.seasons.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Localizable.season.localized + " \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showProgress.seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? EpisodeTableCell else {
            return UITableViewCell()
        }
        let episode = showProgress.seasons[indexPath.section].episodes[indexPath.row]
        
        cell.episode = episode
        cell.delegate = self
        cell.showSeasonsAndEpisodesViewModel = ShowSeasonsAndEpisodesViewModel(delegate: cell, show: showToDetail, showProgress: showProgress)
        cell.seasonNumber = indexPath.section
        cell.configure()
        
        return cell
    }
}

extension ShowSeasonsAndEpisodesController: ShowSeasonsAndEpisodesControllerDelegate {
    func atualizeShowProgressStatus() {
        showSeasonsAndEpisodesViewModel.fetchDetailShow(id: showToDetail.ids.trakt)
    }
    
    func presentError(error: String) {
        alert(message: error, completion: {})
    }
}

extension ShowSeasonsAndEpisodesController: StatusDelegate {
    func loaded(status: Status) {
        switch status {
        case .success:
            showProgress = showSeasonsAndEpisodesViewModel.showProgress
        case .failed(let error):
            alert(message: error, completion: {})
        }
    }
}
