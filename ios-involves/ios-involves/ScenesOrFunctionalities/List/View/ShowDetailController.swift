//
//  ShowDetailController.swift
//  ios-involves
//
//  Created by Danilo Pena on 28/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class ShowDetailController: UIViewController {

    private var showDetailViewModel: ShowDetailViewModel!
    var showIdToDetail: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDetailViewModel = ShowDetailViewModel(delegate: self)
        showDetailViewModel.fetchDetailShow(id: showIdToDetail)
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

extension ShowDetailController: ShowDetailViewModelDelegate {
    func loaded(status: Status) {
        
    }
}
