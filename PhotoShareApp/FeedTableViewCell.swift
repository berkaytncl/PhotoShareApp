//
//  FeedTableViewCell.swift
//  PhotoShareApp
//
//  Created by Berkay Tuncel on 8.01.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
