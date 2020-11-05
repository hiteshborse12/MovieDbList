//
//  SimilarResultsCollectionViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit
import SDWebImage
class SimilarResultsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var containerView: UIView!
    var movie :MovieModel?{
        didSet{
            if let name = movie?.title{
                labelMovieName.text = "\(name) "
            }else {
                labelMovieName.text = ""
            }
            if let url = movie?.fullPosterPath{
                imageMovie.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imageMovie.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
            else {
                imageMovie.image = UIImage.init(named: "placeholder")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        labelMovieName.textColor = .white
        labelMovieName.font = .boldSystemFont(ofSize: 15)
        containerView.layer.cornerRadius = 3
        imageMovie.image = UIImage(named: "placeholder")
        imageMovie.alpha = 0.80

    }

}
