//
//  LoginViewController.swift
//  GongSaeng
//
//  Created by 조영우 on 2021/05/17.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let userViewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idTextField.underlined(viewSize: view.bounds.width, color: UIColor.systemGray)
        passwordTextField.underlined(viewSize: view.bounds.width, color: UIColor.systemGray)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapBG(_ sender: Any) {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @IBAction func loginButtonTapHandler(_ sender: Any) {
        // id, password check
        // 두 유저가 같다는 것은 id와 비번이 모두 같은 것임을 정의했다.
        guard let loginUser = loginUserCreate(id: idTextField.text, password: passwordTextField.text) else { return }
        guard userViewModel.isCorrectUser(user: loginUser) else {
            // after alert, return
            let alert = UIAlertController(title: "로그인 정보가 일치하지 않습니다.", message: "아이디나 비밀번호를 확인해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        // permission check
        guard userViewModel.doneUser.contains(loginUser) else {
            // after alert, return
            let alert = UIAlertController(title: "가입승인 대기중입니다.", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func loginUserCreate(id: String?, password: String?) -> User? {
        guard let idString = id, let passwordString = password else { return nil }
        var user = User(id: "", password: "", isDone: false, name: "", dateOfBirth: "", phoneNumber: "", department: "")
        user.loginUserCreate(id: idString, password: passwordString)
        return user
    }
}

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor){
        let border = CALayer()
        let width = CGFloat(1)
//        border.borderColor = UIColor.gray.cgColor
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
