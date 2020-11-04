//
//  CastCrewCollectionViewCell.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import UIKit

class CastCrewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCast: UIImageView!
    @IBOutlet weak var labelCastName: UILabel!
    var cast :MovieCastModel?{
        didSet{
            labelCastName.text = cast?.name
            //TODO set imag
        }
    }
    var crew :MovieCrewModel?{
        didSet{
            labelCastName.text = crew?.name
            //TODO set imag
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCast.layer.cornerRadius = imageCast.frame.width/2
        labelCastName.font = .systemFont(ofSize: 12)
    }

}
