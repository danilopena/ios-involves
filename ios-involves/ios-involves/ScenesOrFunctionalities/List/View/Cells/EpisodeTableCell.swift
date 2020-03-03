//
//  EpisodeTableCell.swift
//  ios-involves
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class EpisodeTableCell: UITableViewCell {

    @IBOutlet weak var episodeNumber: GrayLabel!
    @IBOutlet weak var watched: GrayLabel!
    @IBOutlet weak var watchOrientation: GrayLabel!
    @IBOutlet weak var watch: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var episode: TraktEpisodeWatchedProgress!
    var showSeasonsAndEpisodesViewModel: ShowSeasonsAndEpisodesViewModel!
    var seasonNumber: Int!
    var delegate: ShowSeasonsAndEpisodesControllerDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        watch.isHidden = false
        watchOrientation.isHidden = false
        watched.isHidden = false
    }
    
    func setup () {
        watch.setTitle(Localizable.watch.localized, for: .normal)
        watchOrientation.text = Localizable.watchOrientation.localized
    }
    
    // Testar se escondeu ou não no test unitario
    func configure() {
        self.episodeNumber.text = Localizable.episode.localized + "\(episode.number)"
        self.watched.text = episode.completed ? Localizable.episodeHasWatched.localized : Localizable.episodeNotWatched.localized
        
        if episode.completed {
            hideWatchOptions()
        } else {
            // Passing season number to watch with section.
            watch.tag = seasonNumber + 1
            watched.isHidden = true
        }
    }
    
    func hideWatchOptions() {
        watch.isHidden = true
        watchOrientation.isHidden = true
    }
    
    @IBAction func watch(_ sender: UIButton) {
        watch.isHidden = true
        activityIndicator.startAnimating()
        showSeasonsAndEpisodesViewModel.watch(episodeNumber: episode.number, seasonNumber: sender.tag)
    }
}

extension EpisodeTableCell {
    private enum Localizable {
        static let episode           = "seasonsAndEpisodes.episode"
        static let episodeHasWatched = "seasonsAndEpisodes.hasWatched"
        static let episodeNotWatched = "seasonsAndEpisodes.notWatched"
        static let watch             = "seasonsAndEpisodes.markWatched"
        static let watchOrientation  = "seasonsAndEpisodes.watchOrientation"
    }
}

extension EpisodeTableCell: StatusDelegate {
    func loaded(status: Status) {
        switch status {
        case .success:
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.watched.isHidden = false
                self.watched.text = Localizable.episodeHasWatched.localized
                self.hideWatchOptions()
                self.delegate.atualizeShowProgressStatus()
            }
            break
        case .failed(let error):
            self.delegate.presentError(error: error)
            break
        }
    }
}
