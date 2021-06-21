//
//  Public.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/06/13.
//

import Foundation
import UIKit

struct Public: Codable, Equatable {
    var imgTitle: String
    var title: String
    var isDone: Bool
    var finalTime: Int
    var remainingTime: Int
    var usingUser: String
    var use: Bool
    
    mutating func update(imgTitle: String, title: String, isDone: Bool, finalTime: Int, remainingTime: Int, usingUser: String, use: Bool) {
        self.imgTitle = imgTitle
        self.title = title
        self.isDone = isDone
        self.finalTime = finalTime
        self.remainingTime = remainingTime
        self.usingUser = usingUser
        self.use = use // true: using
    }
}

class PublicViewModel {
    enum Section: Int, CaseIterable {
        case using
        case toUse
        
        var title: String {
            switch self {
            case .using: return "사용중"
            default: return "사용하기"
            }
        }
    }
    
    var publics: [Public] = [
        Public(imgTitle: "qwer", title: "세탁기1", isDone: true, finalTime: Date().minite, remainingTime: 10, usingUser: "1234", use: false),
        Public(imgTitle: "asdf", title: "세탁기2", isDone: false, finalTime: Date().minite, remainingTime: 20, usingUser: "1234", use: true),
        Public(imgTitle: "qwer", title: "세탁기1", isDone: true, finalTime: Date().minite, remainingTime: 10, usingUser: "jyy0223", use: false),
        Public(imgTitle: "asdf", title: "세탁기2", isDone: false, finalTime: Date().minite, remainingTime: 20, usingUser: "jyy0223", use: true)
    ]
    
    var usingPublics: [Public] {
        return publics.filter { $0.use == true }
    }
    
    var availablePublics: [Public] {
        return publics.filter { $0.use == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    var numOfItems: Int {
        return publics.count
    }

    func indexOfImgTitle(at index: Int) -> String {
        return publics[index].imgTitle
    }
    
    func indexOfPublic(at index: Int) -> Public {
        return publics[index]
    }
}
