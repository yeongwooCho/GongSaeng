//
//  Date.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/06/13.
//

import Foundation


extension Date {
    private static var dateFormatExtension: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_kr")
        dateFormat.timeZone = TimeZone(abbreviation: "KST")
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat
    }
    
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    // 현재 시간을 string 로 반환
    static var currentTime: String {
        let dateFormat = self.dateFormatExtension
        return dateFormat.string(from: Date())
    }
}
