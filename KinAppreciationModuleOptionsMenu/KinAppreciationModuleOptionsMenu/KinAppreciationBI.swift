//
//  KinAppreciationBI.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 20/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import Foundation

public enum KinButtonType {
    case k1
    case k5
    case k10
    case k20
}

public enum KinDismissalReason {
    case xButton
    case backgroundTap
    case timeout
    case hostApp
}

public protocol KinAppreciationBIDelegate: NSObjectProtocol {
    func overlayViewed()
    func buttonSelected(type: KinButtonType)
    func closed(reason: KinDismissalReason)
}

class KinAppreciationBI {
    static let shared = KinAppreciationBI()
    weak var delegate: KinAppreciationBIDelegate?
}
