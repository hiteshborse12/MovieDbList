//
//  MovieListTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonBook: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var movieObj :MovieModel?{
        didSet{
            self.labelTitle.text = movieObj?.originalTitle ?? ""
            self.labelReleaseDate.text = movieObj?.releaseDate ?? ""
            self.labelDescription.text = "\(movieObj?.voteCount ?? 0)  │  Rate: \(movieObj?.voteAverage ?? 0)/10"
            // TODO: Set Image
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .backgroundGrey
    }
}
