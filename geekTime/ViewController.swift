//
//  ViewController.swift
//  geekTime
//
//  Created by 陈诚 on 2019/12/13.
//  Copyright © 2019 陈诚. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .custom)
        button.setTitle("click", for: .normal)
        button.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
    }
    
    @objc func didClickButton () {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }

}

