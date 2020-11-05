//
//  MovieDeatilHeaderTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit
import SDWebImage
class MovieDeatilHeaderTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageMovieBanner: UIImageView!
    @IBOutlet weak var imageMoviePoster: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelDateDuration: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    var moviewDetailModel :MoviewDetailModel?{
        didSet{
            labelMovieTitle.text = moviewDetailModel?.title
            var genre = ""
            for genreText in moviewDetailModel?.genres ?? []{
                genre.append("\(genreText.name ?? ""), ")
            }
            labelGenre.text = genre
            labelDescription.text = moviewDetailModel?.overview
            labelRating.text = "\(moviewDetailModel?.voteAverage ?? 0)/10"
            
            // Set releaseDate and runtime
            var dateToDisplay = ""
            if let releaseData = CustomDateFormatter.dateFromString(dateFormat: .yyyyMMddHyphen, dateString: moviewDetailModel?.releaseDate ?? ""){
                dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .dateMonthYear,
                                                                   dateToConvert: releaseData)
            }
            
            let tuple  = CommonMethods.minutesToHoursMinutes(minutes: moviewDetailModel?.runtime ?? 0)
            let duration = "\(tuple.hours)h \(tuple.leftMinutes)m"
            labelDateDuration.text = "\(dateToDisplay) • \(duration)"
            //TODO set image and other moviewDetails
            if let url = moviewDetailModel?.fullBackdropPath{
                imageMovieBanner.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imageMovieBanner.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
            
            if let url = moviewDetailModel?.fullPosterPath{
                imageMoviePoster.sd_imageIndicator = SDWebImageActivityIndicator.gray
                imageMoviePoster.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "placeholder"), options: .highPriority, context: [:])
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setDisplayUI()
    }
    
    func setDisplayUI(){
        imageMovieBanner.clipsToBounds = true
        imageMovieBanner.layer.cornerRadius = 5
        labelMovieTitle.font = .boldSystemFont(ofSize: 18)
        labelRating.font = .boldSystemFont(ofSize: 15)
        labelDateDuration.textColor = .darkGray
        labelDateDuration.font = .systemFont(ofSize: 11)
        labelGenre.textColor = .darkGray
        labelGenre.font = .systemFont(ofSize: 11)
        labelDescription.font = .systemFont(ofSize: 13)
    }
}
