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
    private var listDetailViewModel: ListDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        listDetailViewModel = ListDetailViewModel(delegate: self)
        listDetailViewModel.fetchListDetail(list: listToDetail)
        navigationItem.title = listToDetail.name
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

extension ListDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailViewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ListDetailTableCell
        if let item = listDetailViewModel.items?[indexPath.row] {
            cell?.configure(item: item)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Preciso pegar o aired e o completed para calcular quantos % está finalizado.
        // Além disso, preciso validar para detalhar apenas Shows
        if let item = listDetailViewModel.items?[indexPath.row] {
            TraktManager.sharedManager.getShowWatchedProgress(showID: "\(item.show?.ids.trakt ?? 0)") { [weak self] (result) in
                switch result {
                    case .success(let result):
                        break
                    case .error(let error):
                        break
                }
            }
        }
        
    }
}

private extension ListDetailController {
    private enum Constants {
        static let cellIdentifier = "itemCell"
    }
}

extension ListDetailController: ListDetailViewModelDelegate {
    func loaded(state: State) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
