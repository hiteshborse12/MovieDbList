//
//  CommonMethods.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation
import UIKit

class CommonMethods {
    
    static func setRootController(rootVC: UIViewController){
        Constant.appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        Constant.appDelegate.window?.rootViewController = UINavigationController(rootViewController: rootVC)
        Constant.appDelegate.window?.backgroundColor = UIColor.white
        Constant.appDelegate.window?.makeKeyAndVisible()
    }
    
    static func showToast(messsage: String, view: UIView) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.black
        DispatchQueue.main.async {
            view.makeToast(messsage, duration: 3.0, position: .bottom, style: style)
        }
    }
}
