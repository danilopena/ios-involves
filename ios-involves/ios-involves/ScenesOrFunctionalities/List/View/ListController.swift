//
//  SeriesListController.swift
//  ios-involves
//
//  Created by Danilo Pena on 23/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class ListController: UIViewController {

    @IBOutlet weak var tableView:   UITableView!
    @IBOutlet weak var orientation: UILabel!
    
    private var listViewModel: ListViewModel!
    var indexOfSelectedList: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel  = ListViewModel(delegate: self)
        listViewModel.fetchLists()
        
        setup()
    }
    
    func setup () {
        navigationItem.title = Localizable.controllerTitle.localized
        navigationController?.tabBarItem.title = Localizable.tabBarTitle.localized
        orientation.text = Localizable.orientationList.localized
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.sendToListItems {
            if let list = listViewModel.lists?[indexOfSelectedList] {
                (segue.destination as? ListDetailController)?.listToDetail = list
            }
        }
    }
}

private extension ListController {
    private enum Constants {
        static let cellIdenfier    = "listCell"
    }
    
    private enum Localizable {
        static let controllerTitle = "list.title"
        static let tabBarTitle     = "tabBar.list.title"
        static let orientationList = "list.orientation"
    }
}

extension ListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdenfier) as? ListTableCell,
              let list = listViewModel.lists?[indexPath.row] else {
                return UITableViewCell()
        }
            
        cell.configure(list: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfSelectedList = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.sendToListItems, sender: self)
    }
}

extension ListController: ListViewModelDelegate {
    func loaded(status: Status) {
        switch status {
        case .success:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .failed(let error):
            alert(message: error, completion: {})
        }
    }
}
