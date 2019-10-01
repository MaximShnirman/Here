//
//  TableViewCell.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 01/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let Identifier: String = "TableViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var vicinity: UILabel!
    @IBOutlet weak var href: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        title.text = ""
        vicinity.text = ""
        href.text = ""
        id.text = ""
    }
    
    func setCell(with place: PlaceVM) {
        title.text = place.title
        vicinity.text = place.vicinity
        href.text = place.href
        id.text = place.id
    }
}
