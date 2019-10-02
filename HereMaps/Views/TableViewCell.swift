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
}

extension TableViewCell: ConfigurableCell {
    
    func setupCell(viewModel: RowCellViewModel) {
        guard let vm = viewModel as? CellVM else { return }
        title.text = vm.title
        vicinity.text = vm.vicinity
        href.text = vm.href
        id.text = vm.id
    }
}
