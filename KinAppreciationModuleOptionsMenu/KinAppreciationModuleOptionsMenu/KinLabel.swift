//
//  KinLabel.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 19/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

class KinLabel: UIButton {
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let image = UIImage(named: "Kin", in: .appreciation, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)

        adjustsImageWhenHighlighted = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isEnabled: Bool {
        didSet {
            imageView?.tintColor = titleColor(for: isEnabled ? .normal : .disabled)
        }
    }

    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)

        if state == .normal {
            imageView?.tintColor = color
        }
    }
}
