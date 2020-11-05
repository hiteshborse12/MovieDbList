//
//  CastCrewCollectionViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

import SDWebImage
class CastCrewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCast: UIImageView!
    @IBOutlet weak var labelCastName: UILabel!
    var cast :MovieCastModel?{
        didSet{
            labelCastName.text = cast?.name
            if let url = cast?.fullProfilePath{
                imageCast.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imageCast.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
            else {
                imageCast.image = UIImage.init(named: "placeholder")
            }
        }
    }
    var crew :MovieCrewModel?{
        didSet{
            labelCastName.text = crew?.name
            if let url = crew?.fullProfilePath{
                imageCast.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imageCast.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
            else {
                imageCast.image = UIImage.init(named: "placeholder")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCast.layer.cornerRadius = imageCast.frame.width/2
        labelCastName.font = .systemFont(ofSize: 12)
    }

}
