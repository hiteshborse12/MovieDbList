//
//  MovieDeatilHeaderTableViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class MovieDeatilHeaderTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageMovieBanner: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelDateDuration: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    var releaseDateStr = "2020-10-26"
    var runtime = 106
    
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
        var dateToDisplay = ""
        if let releaseData = CustomDateFormatter.dateFromString(dateFormat: .yyyyMMddHyphen, dateString: releaseDateStr){
            dateToDisplay = CustomDateFormatter.stringFromDate(dateFormat: .dateMonthYear,
                                                               dateToConvert: releaseData)
        }
        
        let tuple  = CommonMethods.minutesToHoursMinutes(minutes: runtime)
        let duration = "\(tuple.hours)h \(tuple.leftMinutes)m"
        labelDateDuration.text = "\(dateToDisplay) • \(duration)"
    }
}
