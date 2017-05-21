//
//  AccountTableViewCell.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    //MARK: - ==========  var define ==========
    @IBOutlet var imgAcc: UIImageView!
    @IBOutlet var lblNameAcc: UILabel!
    @IBOutlet var lblMoney: UILabel!

    //MARK: - ========== override methods ==========
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
