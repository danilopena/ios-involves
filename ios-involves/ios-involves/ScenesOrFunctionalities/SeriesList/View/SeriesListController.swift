//
//  SeriesListController.swift
//  ios-involves
//
//  Created by Danilo Pena on 23/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class SeriesListController: UIViewController {

    @IBOutlet weak var tableView:   UITableView!
    @IBOutlet weak var orientation: UILabel!
    
    private var seriesListViewModel: SeriesListViewModel!
    var indexOfSelectedList: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesListViewModel  = SeriesListViewModel(delegate: self)
        seriesListViewModel.fetchLists()
        
        setup()
    }
    
    func setup () {
        navigationItem.title = Localizable.controllerTitle.localized
        navigationController?.tabBarItem.title = Localizable.tabBarTitle.localized
        orientation.text = Localizable.orientationList.localized
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.sendToDetailList {
            if let list = seriesListViewModel.lists?[indexOfSelectedList] {
                (segue.destination as? ListDetailController)?.listToDetail = list
            }
        }
    }
}

private extension SeriesListController {
    private enum Constants {
        static let cellIdenfier    = "listCell"
    }
    
    private enum Localizable {
        static let controllerTitle = "list.title"
        static let tabBarTitle     = "tabBar.list.title"
        static let orientationList = "list.orientation"
    }
}

extension SeriesListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesListViewModel.lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdenfier) as? ListTableCell
        if let list = seriesListViewModel.lists?[indexPath.row] {
            cell?.configure(list: list)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfSelectedList = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.sendToDetailList, sender: self)
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
