//
//  UIImage.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//


import Foundation
import UIKit

extension UIImage {
    // Set opacity to image
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
