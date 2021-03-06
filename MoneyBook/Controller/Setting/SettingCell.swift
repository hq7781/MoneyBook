//
//  SettingCell.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/14/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

enum SettingCellType: Int {
    case about = 0
    case score = 1
    case recommend = 2
    case feedback = 3
    case clean = 4
    case purchase = 5
    case verinfo = 6
}

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var setimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView.alpha = 0.3
        sizeLabel.isHidden = true
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func settingCellWithTableView(_ tableView: UITableView) -> SettingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingCell
        return cell
    }
    
}
