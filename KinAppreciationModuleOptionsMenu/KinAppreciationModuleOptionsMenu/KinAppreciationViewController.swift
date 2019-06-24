//
//  KinAppreciationViewController.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 17/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit
import KinSDK

public class KinAppreciationViewController: UIViewController {
    var balance: Kin
    let theme: Theme

    weak var biDelegate: KinAppreciationBIDelegate? {
        didSet {
            KinAppreciationBI.shared.delegate = biDelegate
        }
    }

    private var kButtons: [KinButton] = []

    private var dismissalReason: KinDismissalReason = .hostApp

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

        _view.closeButton.addTarget(self, action: #selector(xTappedAction), for: .touchUpInside)

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

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        KinAppreciationBI.shared.delegate?.overlayViewed()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        KinAppreciationBI.shared.delegate?.closed(reason: dismissalReason)
    }

    // MARK: Amount

    private func setAmountTitle() {
        _view.amountButton.setTitle("\(balance)", for: .normal)
    }
}

// MARK: - Actions

extension KinAppreciationViewController {
    @objc private func kButtonAction(_ button: KinButton) {
        if let type = kButtonToBIMap(button: button) {
            KinAppreciationBI.shared.delegate?.buttonSelected(type: type)
        }

        for kButton in kButtons {
            if kButton != button {
                kButton.isEnabled = false
            }
        }
    }

    @objc private func xTappedAction() {
        dismissalReason = .xButton

        presentingViewController?.dismiss(animated: true)
    }

    @objc private func backgroundTappedAction() {
        dismissalReason = .backgroundTap

        presentingViewController?.dismiss(animated: true)
    }
}

// MARK: - Kin Button

extension KinAppreciationViewController: KinButtonDelegate {
    func kinButtonDidFill(_ button: KinButton) {
        balance -= button.kin
        setAmountTitle()

        button.superview?.bringSubviewToFront(button)

        let confettiView = ConfettiView(frame: button.bounds)
        confettiView.delegate = self
        confettiView.count = 30
        button.superview?.insertSubview(confettiView, belowSubview: button)
        confettiView.translatesAutoresizingMaskIntoConstraints = false
        confettiView.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        confettiView.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        confettiView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        confettiView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        confettiView.explodeAnimation()
    }
}

// MARK: - Transitioning Delegate

extension KinAppreciationViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.tapGesture.addTarget(self, action: #selector(backgroundTappedAction))
        return presentationController
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(presenting: true)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(presenting: false)
    }
}

// MARK: - Confetti View

extension KinAppreciationViewController: ConfettiViewDelegate {
    func confettiViewDidComplete(_ confettiView: ConfettiView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.dismissalReason = .timeout

            strongSelf.presentingViewController?.dismiss(animated: true)
        }
    }
}

// MARK: - BI

extension KinAppreciationViewController {
    private func kButtonToBIMap(button: KinButton) -> KinButtonType? {
        if button.kin == 1 {
            return .k1
        }
        else if button.kin == 5 {
            return .k5
        }
        else if button.kin == 10 {
            return .k10
        }
        else if button.kin == 20 {
            return .k20
        }

        return nil
    }

}
