//
//  SettingSectionHeader.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import UIKit

class SettingSectionHeader: UIView {

    @IBOutlet weak var labelheader: UILabel!

    static func loadNib() -> SettingSectionHeader {
        return UINib(nibName: "SettingSectionHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SettingSectionHeader
    }

    override func awakeFromNib() {
        self.backgroundColor = .backgroundGrey
        labelheader.textColor = .purpleTheme
        labelheader.font = .boldSystemFont(ofSize: 14)
    }
}
