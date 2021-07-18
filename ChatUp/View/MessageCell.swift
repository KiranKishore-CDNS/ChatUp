//
//  MessageCell.swift
//  ChatUp
//
//  Created by Kiran Kishore on 15/07/21.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
