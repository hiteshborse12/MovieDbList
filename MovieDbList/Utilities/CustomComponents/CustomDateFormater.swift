//
//  CustomDateFormater.swift
//  MovieDbList
//
//  Created by webwerks on 03/11/20.
//

import Foundation

enum DateFormatType : String {
    case serverType = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    case yyyyMMddHyphen = "yyyy-MM-dd"
    case dateMonthYear = "d MMM, yyyy"
}

class CustomDateFormatter {
    
    static func stringFromDate(dateFormat: DateFormatType, dateToConvert: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: dateToConvert)
    }
    
    static func dateFromString(dateFormat: DateFormatType, dateString: String) -> Date! {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.date(from: dateString)
    }
}
