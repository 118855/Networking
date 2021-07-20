//
//  PostTableViewCell.swift
//  Practice_Networking
//
//  Created by admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var postLabel: UILabel!
    
    static let identifier = "PostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(post: Post){
        titleLabel.text = "Title: \(post.title ?? "")"
        postLabel.text = "Post: \(post.body ?? "")"
    }
}
