//
//  PiscinesTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/20/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit

class PiscinesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var piscineName: UILabel!
    @IBOutlet weak var piscineMark: UILabel!
    @IBOutlet weak var piscineTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

extension PiscinesTableViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return UITableViewCell()
    }
}
