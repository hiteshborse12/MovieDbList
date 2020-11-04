//
//  ReviewTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelSeparator: UILabel!
    @IBOutlet weak var buttonViewAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setUpDisplay()
    }
    
    func setUpDisplay(){
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        labelUserName.font = .boldSystemFont(ofSize: 13)
        labelReview.font = .systemFont(ofSize: 13)
        buttonViewAll.titleLabel?.font = .boldSystemFont(ofSize: 14)
        buttonViewAll.setTitleColor(.purpleTheme, for: .normal)
        labelSeparator.backgroundColor = .borderGrey
    }
}
