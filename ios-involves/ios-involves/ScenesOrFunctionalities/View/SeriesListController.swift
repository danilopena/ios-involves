//
//  SeriesListController.swift
//  ios-involves
//
//  Created by Danilo Pena on 23/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class SeriesListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var seriesListViewModel: SeriesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesListViewModel = SeriesListViewModel(delegate: self)
        seriesListViewModel.fetchLists()
        navigationItem.title = "Suas listas"
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

private extension SeriesListController {
    private enum Constants {
        static let cellIdenfier = "listCell"
    }
}

extension SeriesListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesListViewModel.lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdenfier)
        return cell!
    }
}

extension SeriesListController: SeriesListViewModelDelegate {
    func loaded(state: State) {
        switch state {
        case .success:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .failed(let error):
            alert(message: error, completion: {})
        }
    }
}
