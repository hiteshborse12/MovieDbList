//
//  SeartchTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import UIKit
import SDWebImage
class SeartchTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var movieObj:MovieModel?{
        didSet{
            self.labelTitle.text = movieObj?.title
            self.layoutIfNeeded()
            if let url = movieObj?.fullPosterPath{
                imagePicture.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imagePicture.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
            else {
                imagePicture.image = UIImage.init(named: "placeholder")
            }

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
