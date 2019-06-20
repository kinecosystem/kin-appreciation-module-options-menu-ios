//
//  KinAppreciationView.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 19/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

class KinAppreciationView: UIView {
    var theme: Theme = .light {
        didSet {
            updateTheme()
        }
    }

    fileprivate let stackView = UIStackView()
    fileprivate let titleButton = UIButton()
    let amountButton = KinAmountButton()
    let closeButton = UIButton()
    let k1Button = KinButton()
    let k5Button = KinButton()
    let k10Button = KinButton()
    let k20Button = KinButton()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        var layoutMargins = self.layoutMargins
        layoutMargins.top = 20
        layoutMargins.bottom = layoutMargins.top
        self.layoutMargins = layoutMargins

        stackView.axis = .vertical
        stackView.spacing = 24
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true

        amountButton.isUserInteractionEnabled = false
        stackView.addArrangedSubview(amountButton)

        titleButton.setTitle("title".localized(), for: .normal)
        titleButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        titleButton.isUserInteractionEnabled = false
        stackView.addArrangedSubview(titleButton)

        k1Button.setTitle("button.k1".localized(), for: .normal)
        k1Button.kin = 1
        stackView.addArrangedSubview(k1Button)

        k5Button.setTitle("button.k5".localized(), for: .normal)
        k5Button.kin = 5
        stackView.addArrangedSubview(k5Button)

        k10Button.setTitle("button.k10".localized(), for: .normal)
        k10Button.kin = 10
        stackView.addArrangedSubview(k10Button)

        k20Button.setTitle("button.k20".localized(), for: .normal)
        k20Button.kin = 20
        stackView.addArrangedSubview(k20Button)

        closeButton.setImage(UIImage(named: "X", in: .appreciation, compatibleWith: nil), for: .normal)
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize

        for subview in stackView.arrangedSubviews {
            size.height += max(subview.bounds.height, subview.intrinsicContentSize.height)
        }

        size.height += stackView.spacing * CGFloat(stackView.arrangedSubviews.count - 1)
        size.height += layoutMargins.top + layoutMargins.bottom

        if #available(iOS 11.0, *),
            let safeAreaInsets = UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets
        {
            size.height += safeAreaInsets.bottom
        }

        return size
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var contentEdgeInsets = closeButton.contentEdgeInsets
        contentEdgeInsets.top = layoutMargins.top
        contentEdgeInsets.left = layoutMargins.left
        contentEdgeInsets.bottom = contentEdgeInsets.top
        contentEdgeInsets.right = contentEdgeInsets.left
        closeButton.contentEdgeInsets = contentEdgeInsets
    }
}

// MARK: - Theme

extension KinAppreciationView: ThemeProtocol {
    func updateTheme() {
        switch theme {
        case .light:
            backgroundColor = .white
            amountButton.setTitleColor(.kinPurple, for: .normal)
            titleButton.setTitleColor(.gray31, for: .normal)

        case .dark:
            backgroundColor = .white
            amountButton.setTitleColor(.kinPurple, for: .normal)
            titleButton.setTitleColor(.gray31, for: .normal)
        }

        amountButton.theme = theme
        k1Button.theme = theme
        k5Button.theme = theme
        k10Button.theme = theme
        k20Button.theme = theme
    }
}
