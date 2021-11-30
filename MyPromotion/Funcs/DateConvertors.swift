//
//  DateConvertors.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/28.
//

import SwiftUI

struct DateConvertors {
    // yyyy-mm-ddへのString整形
    func dateToStringConvert(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func stringToDateConvert(datestr : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let datestring = dateFormatter.date(from: datestr)
        return datestring!
    }
}
