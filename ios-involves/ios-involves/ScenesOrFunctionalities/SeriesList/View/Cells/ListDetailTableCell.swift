//
//  ListDetailTableCell.swift
//  ios-involves
//
//  Created by Danilo Pena on 27/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//
import UIKit
import TraktKit

class ListDetailTableCell: UITableViewCell {

    @IBOutlet weak var name:     UILabel!
    @IBOutlet weak var year:     UILabel!
    @IBOutlet weak var type:     UILabel!
    @IBOutlet weak var typeIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: TraktListItem) {
        var infos: (name: String?, year: Int?)!
        if let movie = item.movie {
            infos = (movie.title, movie.year)
        } else if let show = item.show {
            infos = (show.title, show.year)
        }
        
        name.text = Localizable.listDetailName.localized + (infos.0 ?? "")
        year.text = Localizable.listDetailYear.localized + "\(infos.1 ?? 0)"
        type.text = Localizable.listDetailType.localized + item.type
        //TO-DO adicionar imagem
    }
}

extension ListDetailTableCell {
    private enum Localizable {
        static let listDetailName = "list.detail.name"
        static let listDetailYear = "list.detail.year"
        static let listDetailType = "list.detail.type"
    }
}
