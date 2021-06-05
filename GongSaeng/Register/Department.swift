//
//  Department.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/05/23.
//

import Foundation

struct Department: Codable, Equatable {
    var nameOfDepartment: String
    var addressOfDepartment: String
    var isDone: Bool
    
    mutating func update(name: String, address: String, isDone: Bool) {
        self.nameOfDepartment = name
        self.addressOfDepartment = address
        self.isDone = isDone
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.nameOfDepartment == rhs.nameOfDepartment && lhs.addressOfDepartment == rhs.addressOfDepartment && lhs.isDone == rhs.isDone
    }
}

class DepartmentViewModel {
    var isDoneName: String = ""
    
    var departments: [Department] = [
        Department(nameOfDepartment: "첫번째", addressOfDepartment: "대구", isDone: false),
        Department(nameOfDepartment: "두번째", addressOfDepartment: "부산", isDone: false),
        Department(nameOfDepartment: "3번째", addressOfDepartment: "서울", isDone: false),
        Department(nameOfDepartment: "4번째", addressOfDepartment: "광주", isDone: false),
        Department(nameOfDepartment: "5번째", addressOfDepartment: "울산", isDone: false),
        Department(nameOfDepartment: "6번째", addressOfDepartment: "철원", isDone: false)
    ]
    
    var searchedDepartments: [Department] = [] // 검색된 결과를 여기에 넣도록 하자.
    
    var numOfDepartments: Int {
        return departments.count
    }
    
    var numOfSearchDepartment: Int {
        return searchedDepartments.count
    }
    
    func searchDepartmentOfIndex(at index: Int) -> Department {
        return searchedDepartments[index]
    }
    
    func isDoneDepartment() -> Bool {
        // department의 isDone이 true인 한 놈을 있으면 true, 없다면 false
        let doneDepartments = searchedDepartments.filter { $0.isDone == true }
        if doneDepartments == [] {
            isDoneName = ""
            return false
        } else {
            isDoneName = doneDepartments[0].nameOfDepartment
            return true
        }        
    }
    
    func loadDatas() {
        self.searchedDepartments = self.departments
    }
}
