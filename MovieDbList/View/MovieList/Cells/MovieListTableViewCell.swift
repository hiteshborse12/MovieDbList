//
//  MovieListTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

import SDWebImage
class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePicture: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonBook: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var movieObj :MovieModel?{
        didSet{
            self.labelTitle.text = movieObj?.title ?? ""
            self.labelDescription.text = "\(movieObj?.voteCount ?? 0)  │  Rate: \(movieObj?.voteAverage ?? 0)/10"
            var dateToDisplay = movieObj?.releaseDate ?? ""
            if let releaseData = CustomDateFormatter.dateFromString(dateFormat: .yyyyMMddHyphen, dateString: movieObj?.releaseDate ?? ""){
                dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .dateMonthYear,
                                                                   dateToConvert: releaseData)
            }
            labelReleaseDate.text = dateToDisplay
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
    }
}
