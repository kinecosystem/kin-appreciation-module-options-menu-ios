//
//  Button.swift
//  KinAppreciationModuleOptionsMenu
//
//  Created by Corey Werner on 19/06/2019.
//  Copyright © 2019 Kin Foundation. All rights reserved.
//

import UIKit

class Button: UIControl {
    private let fillContainerView = UIView()
    private let fillTitleLabel = UILabel()
    private var fillWidthConstraint: NSLayoutConstraint

    let titleLabel = UILabel()
    private var titles: [UInt: String?] = [:]
    private var titleColors: [UInt: UIColor?] = [:]

    var kin: Kin = 0 {
        didSet {
            kinLabel.setTitle("\(kin)", for: .normal)
        }
    }
    private let kinLabel = KinLabel()
    private var imageColors: [UInt: UIColor?] = [:]

    var theme: Theme = .light {
        didSet {
            updateAppearance()
        }
    }

    // MARK: Lifecycle

    override init(frame: CGRect) {
        fillWidthConstraint = fillContainerView.widthAnchor.constraint(equalToConstant: 0)
        fillWidthConstraint.isActive = true

        super.init(frame: frame)

        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addSubview(kinLabel)
        kinLabel.translatesAutoresizingMaskIntoConstraints = false
        kinLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        kinLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        kinLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true

        fillContainerView.clipsToBounds = true
        addSubview(fillContainerView)
        fillContainerView.translatesAutoresizingMaskIntoConstraints = false
        fillContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fillContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fillContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        fillTitleLabel.textAlignment = .center
        fillContainerView.addSubview(fillTitleLabel)
        fillTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fillTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fillTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fillTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        fillTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addTarget(self, action: #selector(fillAction), for: .touchUpInside)

        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.masksToBounds = true

        updateAppearance()
    }

    @objc private func fillAction() {
        fillWidthConstraint.constant = bounds.width

        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        updateState()
    }

    // MARK: Layout

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 46
        return size
    }
}

// MARK: - State

extension Button {
    override var isHighlighted: Bool {
        didSet {
            kinLabel.isHighlighted = isHighlighted
            updateState()
        }
    }

    override var isSelected: Bool {
        didSet {
            kinLabel.isSelected = isSelected
            updateState()
        }
    }

    override var isEnabled: Bool {
        didSet {
            kinLabel.isEnabled = isEnabled
            updateState()
        }
    }

    private func updateState() {
        titleLabel.text = hierarchicalTitle(for: state)
        titleLabel.textColor = hierarchicalColor(for: state)

        fillTitleLabel.text = titleLabel.text
    }

    private func nextHierarchicalState(_ state: State) -> State {
        switch state {
        case [.selected, .highlighted]:
            return .selected

        default:
            return .normal
        }
    }

    private func hierarchicalObject<T>(for state: State, function: (_ state: State) -> (T?)) -> T? {
        var state = state

        while state != .normal {
            if let title = function(state) {
                return title
            }

            state = nextHierarchicalState(state)
        }

        return function(.normal)
    }
}

// MARK: - Title Label

extension Button {
    // MARK: Title

    func setTitle(_ title: String?, for state: State) {
        titles[state.rawValue] = title
    }

    func title(for state: State) -> String? {
        return titles[state.rawValue] ?? nil
    }

    private func hierarchicalTitle(for state: State) -> String? {
        return hierarchicalObject(for: state) { title(for: $0) }
    }

    // MARK: Color

    func setTitleColor(_ color: UIColor, for state: State) {
        titleColors[state.rawValue] = color
    }

    func color(for state: State) -> UIColor? {
        return titleColors[state.rawValue] ?? nil
    }

    private func hierarchicalColor(for state: State) -> UIColor? {
        return hierarchicalObject(for: state) { color(for: $0) }
    }
}

// MARK: - Appearance

extension Button {
    private func updateAppearance() {
        switch theme {
        case .light:
            setTitleColor(.gray140, for: .normal)
            setTitleColor(.gray222, for: .disabled)

            kinLabel.setTitleColor(.kinGreen, for: .normal)
            kinLabel.setTitleColor(.gray222, for: .disabled)

            fillTitleLabel.backgroundColor = .kinGreen
            fillTitleLabel.textColor = .white

            layer.borderColor = UIColor.gray222.cgColor

        case .dark:
            layer.borderColor = UIColor.gray.cgColor
        }
    }
}
