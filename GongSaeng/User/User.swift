//
//  User.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/05/18.
//
import UIKit
import Foundation

struct User: Codable, Equatable {
    var id: String // primary key
    var password: String // Hashing String
    var isDone: Bool = false // 관리자 승인여부
    
    var name: String
    var dateOfBirth: String
    var phoneNumber: String
    var department: String
    
    mutating func update(id: String, password: String, name: String, dateOfBirth: String, phoneNumber: String, department: String) {
        self.id = id
        self.password = password
        
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.department = department
    }
    
    mutating func loginUserCreate(id: String, password: String) {
        self.id = id
        self.password = password
        
        self.name = ""
        self.dateOfBirth = ""
        self.phoneNumber = ""
        self.department = ""
    }
    
    mutating func registerUserCreate(name: String, dateOfBirth: String, phoneNumber: String, department: String) {
        self.id = ""
        self.password = ""
        
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.department = department
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.password == rhs.password
    }
}

class UserManager {
    static let shared = UserManager()
    static var lastId: Int = 0
    
    //승인되지 않은 유저 테스트용
    var users: [User] = [User(id: "123", password: "qwe", isDone: false, name: "asd", dateOfBirth: "zxc", phoneNumber: "wer", department: "xcv")]
    
    // 데이터를 생성하고 추가하는 createUser, addUser의 관계를 잘 파악해야 한다.
    func createUser(id: String, password: String, name: String, dateOfBirth: String, phoneNumber: String, department: String) -> User {
        return User(id: id, password: password, name: name, dateOfBirth: dateOfBirth, phoneNumber: phoneNumber, department: department)
    }
    func addUser(_ user: User) {
        users.append(user)
        UserManager.lastId = users.count
        saveUser()
    }
    
    // 회원 탈되 용
    func deleteUser(_ user: User) {
        users = users.filter { $0.id != user.id }
        UserManager.lastId = users.count
        saveUser()
    }
    
    func updateUser(_ user: User) {
        guard let index = users.firstIndex(of: user) else { return }
        users[index].update(id: user.id, password: user.password, name: user.name, dateOfBirth: user.dateOfBirth, phoneNumber: user.phoneNumber, department: user.department)
        saveUser()
    }
    
    func saveUser() {
        // save user data in Firebase
    }
    
    func retrieveUser() {
        // load user data in Firebase
    }
}

class UserViewModel {
    enum Section: Int, CaseIterable {
        case done
        case notDone
        
        var permission: String {
            switch self {
            case .done: return "승인된 인원"
            default: return "승인되지 않은 인원"
            }
        }
    }
    
    private let manager = UserManager.shared
    
    // 밖에서 데이터의 직접 접근을 막자
    private var users: [User] {
        return manager.users
    }
    
    // 승인된 인원 반환
    var doneUser: [User] {
        return users.filter { $0.isDone == true }
    }
    
    // 승인되지 않은 인원 반환
    var notDoneUser: [User] {
        return users.filter { $0.isDone == false }
    }
    
    var usersId: [String]  {
        return manager.users.map { $0.id }
    }
    
    var numOfUsers: Int {
        return self.users.count
    }
    
    // 두 유저가 같은 것은 id, password가 모두 같음을 정의했다.
    func isCorrectUser(user: User) -> Bool {
        for element in users {
            if element == user {
                print("데이터가 존재합니다")
                return true
            }
        }
        return false
    }
    
    func addUser(_ user: User) {
        manager.addUser(user)
    }
    
    func deleteUser(_ user: User) {
        manager.deleteUser(user)
    }
    
    func updateUser(_ user: User) {
        manager.updateUser(user)
    }
    
    func loadTaskUsers() {
        manager.retrieveUser()
    }
}
