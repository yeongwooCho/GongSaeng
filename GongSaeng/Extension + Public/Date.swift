//
//  Date.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/06/13.
//

import Foundation


extension Date {
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
}

