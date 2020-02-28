//
//  WatchingSeriesListController.swift
//  ios-involves
//
//  Created by Danilo Pena on 26/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class WatchingSeriesListController: UIViewController {

    var watchingViewModel: WatchingSeriesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        watchingViewModel = WatchingSeriesViewModel(delegate: self)
        watchingViewModel.fetchWatching()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WatchingSeriesListController: WatchingSeriesViewModelDelegate {
    func loaded(state: State) {
        
    }
}
