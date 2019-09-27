//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by Matthew O'Connor on 9/27/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

protocol ShoppingTableViewCellDelegate {
    func buttonTapped(_ sender: ShoppingTableViewCell)
}

class ShoppingTableViewCell: UITableViewCell {
    var delegate: ShoppingTableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(self)
    }
    
    func updateViews(shopping: Shopping) {
        nameLabel.text = shopping.name
        updateButton(shopping.isComplete)
//        if shopping.isComplete {
//            completeButton.setImage(UIImage(named: "complete"), for: .normal)
//        } else {
//            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
//        }
    }
    
    func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
