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

        createButton(theme: .light, offset: 50, balance: 9)
        createButton(theme: .dark, offset: 150, balance: 100)
    }

    func createButton(theme: Theme, offset: CGFloat, balance: Int) {
        let title: String
        let selector: Selector

        switch theme {
        case .light:
            title = "Light mode"
            selector = #selector(lightAction(_:))
        case .dark:
            title = "Dark mode"
            selector = #selector(darkAction(_:))
        }

        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.tag = balance
        button.layer.cornerRadius = 10
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: offset).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func lightAction(_ button: UIButton) {
        let viewController = KinAppreciationViewController(balance: Decimal(button.tag), theme: .light)
        viewController.delegate = self
        present(viewController, animated: true)
    }

    @objc func darkAction(_ button: UIButton) {
        let viewController = KinAppreciationViewController(balance: Decimal(button.tag), theme: .dark)
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

extension ViewController: KinAppreciationViewControllerDelegate {
    func kinAppreciationViewControllerDidPresent(_ viewController: KinAppreciationViewController) {

    }

    func kinAppreciationViewController(_ viewController: KinAppreciationViewController, didDismissWith reason: KinAppreciationViewController.DismissReason) {

    }

    func kinAppreciationViewController(_ viewController: KinAppreciationViewController, didSelect amount: Decimal) {

    }
}
