//
//  KinAppreciationView.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 19/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

class KinAppreciationView: UIView {
    fileprivate let stackView = UIStackView()
    fileprivate let titleLabel = UILabel()
    let amountLabel = UILabel()
    let closeButton = UIButton()
    let k1Button = Button()
    let k5Button = Button()
    let k10Button = Button()
    let k20Button = Button()

    override init(frame: CGRect) {
        super.init(frame: frame)

        var layoutMargins = self.layoutMargins
        layoutMargins.top = 20
        layoutMargins.bottom = layoutMargins.top
        self.layoutMargins = layoutMargins

        backgroundColor = .white

        stackView.axis = .vertical
        stackView.spacing = 24
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true


        amountLabel.text = "K"
        amountLabel.textAlignment = .center
        stackView.addArrangedSubview(amountLabel)

        titleLabel.text = "title".localized()
        titleLabel.textAlignment = .center
        stackView.addArrangedSubview(titleLabel)

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

        closeButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        closeButton.setTitle("X", for: .normal)
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        print("")
    }
}

