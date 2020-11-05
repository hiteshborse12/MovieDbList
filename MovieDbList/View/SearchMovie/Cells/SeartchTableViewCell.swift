//
//  SeartchTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import UIKit

class SeartchTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var movieObj:MovieModel?{
        didSet{
            self.labelTitle.text = movieObj?.title
            self.layoutIfNeeded()
        // TODO: Assign the display values here
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .backgroundGrey
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.borderGrey.cgColor
    }
}
