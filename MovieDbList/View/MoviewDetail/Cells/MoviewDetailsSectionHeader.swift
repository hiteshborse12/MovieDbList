//
//  MoviewDetailsSectionHeader.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation
import UIKit

class MoviewDetailsSectionHeader: UIView {

    @IBOutlet weak var labelSectionTitle: UILabel!
    @IBOutlet weak var labelSeparator: UILabel!

    static func loadNib() -> MoviewDetailsSectionHeader {
        return UINib(nibName: "MoviewDetailsSectionHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MoviewDetailsSectionHeader
    }

    override func awakeFromNib() {
        self.backgroundColor = .backgroundGrey
        labelSectionTitle.textColor = .black
        labelSectionTitle.font = .boldSystemFont(ofSize: 16)
        labelSeparator.backgroundColor = .borderGrey
    }
}
