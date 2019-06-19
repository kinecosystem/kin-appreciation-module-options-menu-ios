//
//  ViewController.swift
//  KinAppreciationModuleOptionsMenuSampleApp
//
//  Created by Corey Werner on 17/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit
import KinAppreciationModuleOptionsMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 50, width: 100, height: 100)
        button.backgroundColor = .red
        button.setTitle("Click?", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func click() {
        let vc = KinAppreciationViewController(balance: 100, theme: .light)
        present(vc, animated: true)
    }

}

