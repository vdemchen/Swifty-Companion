//
//  PisicineTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/21/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit

class PisicineTableViewCell: BaseTableViewCell {
    @IBOutlet weak var piscineLabel: UILabel!
    @IBOutlet weak var piscineStatus: UILabel!
    @IBOutlet weak var piscineMark: UILabel!
    @IBOutlet weak var piscineDaysTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.piscineDaysTableView.dataSource = self as? UITableViewDataSource
        self.piscineDaysTableView.delegate = self as? UITableViewDelegate
        self.piscineDaysTableView.register(PiscineDayTableViewCell.nib(),
                                           forCellReuseIdentifier: PiscineDayTableViewCell.identifier())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
