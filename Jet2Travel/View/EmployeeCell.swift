//
//  EmployeeCell.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 05/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moveNextButton: UIButton!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 2
        backView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
