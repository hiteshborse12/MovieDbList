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
            self.labelTitle.text = movieObj?.title ?? ""
            self.labelDescription.text = "\(movieObj?.voteCount ?? 0)  │  Rate: \(movieObj?.voteAverage ?? 0)/10"
            var dateToDisplay = movieObj?.releaseDate ?? ""
            if let releaseData = CustomDateFormatter.dateFromString(dateFormat: .yyyyMMddHyphen, dateString: movieObj?.releaseDate ?? ""){
                dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .dateMonthYear,
                                                                   dateToConvert: releaseData)
                dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .dateMonthYear,
                                                                   dateToConvert: releaseData)
            }
            labelReleaseDate.text = dateToDisplay
            // TODO: Set Image
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .backgroundGrey
    }
}
