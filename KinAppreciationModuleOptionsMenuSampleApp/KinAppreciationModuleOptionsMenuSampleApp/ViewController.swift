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

        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Present module", for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 10
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func tapped() {
        let viewController = KinAppreciationViewController(balance: 9, theme: .light)
        present(viewController, animated: true)
    }
}

