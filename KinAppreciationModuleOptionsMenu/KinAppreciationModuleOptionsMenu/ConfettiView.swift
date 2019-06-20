//
//  ConfettiView.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 20/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

class ConfettiView: UIView {
    var count = 1
    let confettiSize = CGSize(width: 10, height: 10)

    private var animator: UIDynamicAnimator!

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        animator = UIDynamicAnimator(referenceView: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    private func layoutConfetti(iterator: (_ imageView: UIImageView) -> ()) {
        let insetRect = bounds.insetBy(dx: confettiSize.width / 2, dy: confettiSize.height / 2)

        for i in 0..<count {
            let x = CGFloat(arc4random_uniform(UInt32(insetRect.width))) + insetRect.origin.x
            let y = CGFloat(arc4random_uniform(UInt32(insetRect.height))) + insetRect.origin.y

            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: confettiSize.width, height: confettiSize.height))
            imageView.center = CGPoint(x: x, y: y)
            imageView.backgroundColor = Colors(rawValue: i % Colors.count)?.color
            self.addSubview(imageView)

            iterator(imageView)
        }
    }
}

// MARK: - Animations

extension ConfettiView {
    func explodeAnimation() {
        DispatchQueue.main.async {
            self.layoutConfetti(iterator: { imageView in
                let precision: CGFloat = 1000
                let maxAngle = (2 * CGFloat.pi) * precision
                let angle = CGFloat(arc4random_uniform(UInt32(maxAngle))) / precision

                let pushBehavior = UIPushBehavior(items: [imageView], mode: .instantaneous)
                pushBehavior.setAngle(angle, magnitude: 0.005)
                pushBehavior.action = self.completeExplodeAnimation(pushBehavior, imageView)

                self.animator.addBehavior(pushBehavior)
            })
        }
    }

    private func completeExplodeAnimation(_ pushBehavior: UIPushBehavior, _ imageView: UIImageView) -> (() -> Void) {
        let inset = bounds.height
        let thresholdRect = imageView.frame.insetBy(dx: -inset, dy: -inset)

        return {
            guard !thresholdRect.contains(imageView.center), imageView.tag == 0 else {
                return
            }

            imageView.tag = 1

            UIView.animate(withDuration: 0.3, animations: {
                imageView.alpha = 0
            }, completion: { _ in
                pushBehavior.removeItem(imageView)
                imageView.removeFromSuperview()
            })
        }
    }
}

// MARK: - Colors

extension ConfettiView {
    enum Colors: Int {
        case blue
        case magenta
        case orange
        case pink
        case violet
        case yellow
    }
}

extension ConfettiView.Colors {
    static let count = 6

    var color: UIColor {
        switch self {
        case .blue:
            return UIColor(red: 147/255, green: 107/255, blue: 251/255, alpha: 1)
        case .magenta:
            return UIColor(red: 219/255, green: 74/255, blue: 124/255, alpha: 1)
        case .orange:
            return UIColor(red: 255/255, green: 135/255, blue: 49/255, alpha: 1)
        case .pink:
            return UIColor(red: 225/255, green: 131/255, blue: 233/255, alpha: 1)
        case .violet:
            return UIColor(red: 175/255, green: 65/255, blue: 186/255, alpha: 1)
        case .yellow:
            return UIColor(red: 255/255, green: 214/255, blue: 84/255, alpha: 1)
        }
    }
}
