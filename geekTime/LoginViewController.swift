//
//  LoginViewController.swift
//  geekTime
//
//  Created by 陈诚 on 2019/12/19.
//  Copyright © 2019 陈诚. All rights reserved.
//

import UIKit
import SnapKit

/** 这里用到面向协议编程(逻辑与界面分离)，定义两个协议，用于页面校验，每个协议里面有一个方法(在协议里面所以没有方法实现，方法实现放在下面的extension里面) */
protocol ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool
}

protocol ValidatePassword {
    func validatePassword(_ password: String) -> Bool
}

extension ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.count != 11 {
            return false
        }
        return true
    }
}

extension ValidatePassword {
    func validatePassword(_ password: String) -> Bool {
        if password.count < 6 || password.count > 12 {
            return false
        }
        return true
    }
}

class LoginViewController: BaseViewController, ValidatePhoneNumber, ValidatePassword {
    
    var phoneTextField : UITextField!
    var passwordTexField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoView = UIImageView(image: R.image.logo())//这里使用了R.Swift库很方便的管理我们的图片库，还有代码提示
        view.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        let phoneIconView = UIImageView(image: R.image.icon_phone())
        phoneTextField = UITextField()
        phoneTextField.leftView = phoneIconView
        phoneTextField.leftViewMode = .always//图标永远显示在左边
        phoneTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.textColor = UIColor.hexColor(0x333333)
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.layer.masksToBounds = true
        phoneTextField.placeholder = "请输入手机号"
        view.addSubview(phoneTextField)
        
        phoneTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(logoView.snp_bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let passwordIconView = UIImageView(image: R.image.icon_pwd())
        passwordTexField = UITextField()
        passwordTexField.leftView = passwordIconView
        passwordTexField.leftViewMode = .always//图标永远显示在左边
        passwordTexField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        passwordTexField.layer.borderWidth = 1
        passwordTexField.textColor = UIColor.hexColor(0x333333)
        passwordTexField.layer.cornerRadius = 5
        passwordTexField.isSecureTextEntry = true
        passwordTexField.layer.masksToBounds = true
        passwordTexField.placeholder = "请输入手机号"
        view.addSubview(passwordTexField)
        
        passwordTexField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(phoneTextField.snp_bottom).offset(15)
            make.height.equalTo(50)
        }
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTexField.snp_bottom).offset(20)
            make.height.equalTo(50)
        }
        
        loginButton.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
        
    }
    
    /** 一般的方法前面是不需要写@objc的，但selector对应的方法前面必须加，因为selector其实是 Objective-C runtime 的概念。在 Swift4 中，默认情况下所有的 Swift 方法在Objective-C 中都是不可见的，所以你需要在这类方法前面加上@objc关键字，将这个方法暴露给 Objective-C，才能进行使用。*/

    @objc func didClickLoginButton() {
        if validatePhoneNumber(phoneTextField.text ?? "") &&
            validatePassword(passwordTexField.text ?? "") {
            
        }else {
            self.showToast()
        }
    }
    
    func showToast() {
        let alertVC = UIAlertController(title: "提示", message: "用户名或者密码错误", preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
        
        //过两秒消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }
}
