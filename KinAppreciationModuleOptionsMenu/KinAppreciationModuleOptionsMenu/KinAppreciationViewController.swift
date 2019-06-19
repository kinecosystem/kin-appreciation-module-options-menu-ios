//
//  KinAppreciationViewController.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 17/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

public class KinAppreciationViewController: UIViewController {
    let balance: Kin
    let theme: Theme
    var kButtons: [Button] = []

    // MARK: View

    lazy var _view: KinAppreciationView = {
        return KinAppreciationView()
    }()

    public override func loadView() {
        view = _view

        kButtons = [
            _view.k1Button,
            _view.k5Button,
            _view.k10Button,
            _view.k20Button
        ]
    }

    // MARK: Lifecycle

    public init(balance: Kin, theme: Theme) {
        self.balance = balance
        self.theme = theme
        
        super.init(nibName: nil, bundle: nil)

        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        _view.closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)

        kButtons.forEach { $0.addTarget(self, action: #selector(kButtonAction(_:)), for: .touchUpInside) }
    }
}

// MARK: - Actions

extension KinAppreciationViewController {
    @objc private func closeAction() {
        presentingViewController?.dismiss(animated: true)
    }

    @objc private func kButtonAction(_ button: Button) {
        for kButton in kButtons {
            if kButton != button {
                kButton.isEnabled = false
            }
        }
    }
}

// MARK: - Transitioning Delegate

extension KinAppreciationViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(presenting: true)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(presenting: false)
    }
}
