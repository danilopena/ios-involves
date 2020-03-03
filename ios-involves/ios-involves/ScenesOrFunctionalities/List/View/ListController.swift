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

    
    // -------------      -------------
    // MARK: IBOutlets
    // -------------      -------------

    @IBOutlet weak var tableView:   UITableView!
    @IBOutlet weak var orientation: UILabel!
    
    // -------------      -------------
    // MARK: Variables
    // -------------      -------------
    
    private var listViewModel: ListViewModel!
    var indexOfSelectedList: Int!
    
    // -------------      -------------
    // MARK: Native Functions
    // -------------      -------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel = ListViewModel(delegate: self)
        listViewModel.fetchLists()
        
        setup()
    }
    
    // -------------      -------------
    // MARK: Auxiliar Functions
    // -------------      -------------
    
    func setup () {
        navigationItem.title = listViewModel.controllerTitleString
        navigationController?.tabBarItem.title = listViewModel.tabBarTitleString
        tableView.tableFooterView = UITableViewHeaderFooterView()
        orientation.text = listViewModel.orientationListTitleString
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

extension ListController: StatusDelegate {
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
