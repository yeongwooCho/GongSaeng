//
//  Normalization.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/05/29.
//

import Foundation


class Normalization {
    // 회원가입, 로그인 등 Normalization의 모든 검증을 하는 type method
    static func isValidRegEx(regExKinds: String?, objectString: String?) -> Bool {
        guard regExKinds != nil, objectString != nil else { return false }

        var regEx: String = ""
        switch regExKinds {
        case "name": regEx = "[가-힣]{2,10}"
        case "birth": regEx = "[0-9]{8}"
        case "phone": regEx = "^010?([0-9]{8})"
        default:
            return false
        }
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: objectString)
    }
}
