//
//  GroupTableViewCell.swift
//  Parse Chat
//
//  Created by Nguyen Thanh Thuc on 27/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    var groupText: String? {
        didSet {
            groupLabel.text = groupText
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
