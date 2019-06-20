//
//  KinAppreciationViewController.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 17/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

public class KinAppreciationViewController: UIViewController {
    var balance: Kin
    let theme: Theme
    private var kButtons: [KinButton] = []

    // MARK: View

    lazy var _view: KinAppreciationView = {
        return KinAppreciationView(frame: UIScreen.main.bounds)
    }()

    public override func loadView() {
        _view.theme = theme
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

        setAmountTitle()

        for kButton in kButtons {
            if kButton.kin > balance {
                kButton.isEnabled = false
            }
            else {
                kButton.delegate = self
                kButton.addTarget(self, action: #selector(kButtonAction(_:)), for: .touchUpInside)
            }
        }
    }

    private func setAmountTitle() {
        _view.amountButton.setTitle("\(balance)", for: .normal)
    }
}

// MARK: - Actions

extension KinAppreciationViewController {
    @objc private func closeAction() {
        presentingViewController?.dismiss(animated: true)
    }

    @objc private func kButtonAction(_ button: KinButton) {
        for kButton in kButtons {
            if kButton != button {
                kButton.isEnabled = false
            }
        }
    }
}

// MARK: - Kin Button

extension KinAppreciationViewController: KinButtonDelegate {
    func kinButtonDidFill(_ button: KinButton) {
        balance -= button.kin
        setAmountTitle()
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
