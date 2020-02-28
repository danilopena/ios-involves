//
//  SeriesTableCell.swift
//  ios-involves
//
//  Created by Danilo Pena on 26/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class ListTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var countShows: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(list: TraktList) {
        name.text       = Localizable.listName.localized + list.name
        countShows.text = Localizable.listShowsCount.localized + "\(list.itemCount)"
    }
}

extension ListTableCell {
    private enum Localizable {
        static let listName = "list.name"
        static let listShowsCount = "list.showsCount"
    }
}
