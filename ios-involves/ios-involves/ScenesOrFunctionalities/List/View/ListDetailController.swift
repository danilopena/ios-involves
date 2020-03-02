//
//  SerieListDetailController.swift
//  ios-involves
//
//  Created by Danilo Pena on 26/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class ListDetailController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listToDetail: TraktList!
    var showIndexToDetail: Int!
    private var listDetailViewModel: ListDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        listDetailViewModel = ListDetailViewModel(delegate: self)
        listDetailViewModel.fetchListDetail(list: listToDetail)
        navigationItem.title = listToDetail.name
        tableView.tableFooterView = UITableViewHeaderFooterView()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.sendToDetailShow {
            if let show = listDetailViewModel.items?[showIndexToDetail].show {
                (segue.destination as? ShowDetailController)?.showToDetail = show
            }
        }
    }
}

extension ListDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailViewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ListDetailTableCell,
            let item = listDetailViewModel.items?[indexPath.row]
           else {
            return UITableViewCell()
        }
        
        cell.configure(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Preciso pegar o aired e o completed para calcular quantos % está finalizado.
        if let item = listDetailViewModel.items?[indexPath.row] {
            if let enumType = ItemTypeEnum(rawValue: item.type), enumType == .show {
                showIndexToDetail = indexPath.row
                self.performSegue(withIdentifier: SegueIdentifier.sendToDetailShow, sender: self)
            } else {
                alert(message: Localizable.errorUnknown.localized, completion: {})
            }
        }
    }
}

private extension ListDetailController {
    private enum Constants {
        static let cellIdentifier = "itemCell"
    }
    
    private enum Localizable {
        static let errorUnknown = "error.message.unknown"
    }
}

extension ListDetailController: StatusDelegate {
    func loaded(status: Status) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
