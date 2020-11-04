//
//  SimilarResultsCollectionViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class SimilarResultsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var containerView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelMovieName.textColor = .black
        labelMovieName.font = .boldSystemFont(ofSize: 15)
        containerView.layer.cornerRadius = 3
        imageMovie.image = UIImage(named: "placeholder")?.withAlpha(0.8)

    }

}
