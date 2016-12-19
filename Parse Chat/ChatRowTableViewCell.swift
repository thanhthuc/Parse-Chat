//
//  ChatRowTableViewCell.swift
//  Parse Chat
//
//  Created by Nguyen Thanh Thuc on 19/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class ChatRowTableViewCell: UITableViewCell {

    @IBOutlet weak var msgLabel: UILabel!
    var messageText: String? {
        didSet {
            msgLabel.text = messageText
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
