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
    var isDone: Bool // Using
    var finalTime: Int
    var remainingTime: Int
    var usingUser: String? // 사용중인 유저가 없을 수 있음
    var maxTime: Int // 최대 사용 가능 시간
    
    mutating func update(imgTitle: String, title: String, isDone: Bool, finalTime: Int, remainingTime: Int, usingUser: String, maxTime: Int) {
        self.imgTitle = imgTitle
        self.title = title
        self.isDone = isDone // true: using
        self.finalTime = finalTime
        self.remainingTime = remainingTime
        self.usingUser = usingUser // id
        self.maxTime = maxTime
    }
}

class PublicViewModel {
    enum Section: Int, CaseIterable {
        case using
        case toUse
        
        var title: String {
            switch self {
            case .using: return "사용중" // 내가 사용중 상태
            default: return "사용하기" // 그 외 상태
            }
        }
    }
    
    var publics: [Public] = [
        Public(imgTitle: "qwer", title: "세탁기1", isDone: true, finalTime: Date().minite, remainingTime: 10, usingUser: "1234", maxTime: 100),
        Public(imgTitle: "qwer", title: "세탁기2", isDone: false, finalTime: Date().minite, remainingTime: 20, usingUser: "1234", maxTime: 90),
        Public(imgTitle: "qwer", title: "세탁기3", isDone: true, finalTime: Date().minite, remainingTime: 30, usingUser: "jyy0223", maxTime: 80),
        Public(imgTitle: "qwer", title: "세탁기4", isDone: false, finalTime: Date().minite, remainingTime: 40, usingUser: "jyy0223", maxTime: 70)
    ]
    
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
    
    func usingPublics(loginUser: User?) -> [Public] {
        return publics.filter { $0.isDone == true && $0.usingUser == loginUser?.id}
    }
    
    func availablePublics(loginUser: User?) -> [Public] {
        return publics.filter { !($0.isDone == true && $0.usingUser == loginUser?.id) }
    }
    
    var availablePublics: [Public] {
        return publics.filter { $0.isDone == false }
    }
}
