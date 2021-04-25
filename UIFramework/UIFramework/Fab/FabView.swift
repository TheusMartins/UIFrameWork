//
//  FabView.swift
//  UIFramework
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit

public protocol FabViewControllerHandlerDelegate: class {
    func onFabTap(isShowingMenu: Bool)
}

open class FabView: UIView {
    // MARK: - Public properties
    var actionsList: [FabCellModel]
    
    // MARK: - private properties
    private var isShowingMenu = false
    private let color: UIColor
    private weak var delegate: FabViewControllerHandlerDelegate?
    
    private lazy var fabButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 28
        return view
    }()
    
    private let fabIcon: UIImageView = {
        if #available(iOS 13.0, *) {
            let image = UIImageView(image: UIImage(named: "xIcon", in: Bundle(for: FabView.self), with: nil)?.withRenderingMode(.alwaysTemplate))
            image.translatesAutoresizingMaskIntoConstraints = false
            image.isUserInteractionEnabled = false
            image.tintColor = .white
            return image
        } else {
            return UIImageView()
        }
        
    }()
    
    // MARK: - Initialization
    public init(actionsList: [FabCellModel],
                color: UIColor = .systemPink,
                delegate: FabViewControllerHandlerDelegate? = nil) {
        self.actionsList = actionsList
        self.color = color
        self.delegate = delegate
        super.init(frame: .zero)
        setupViewConfiguration()
        addAction()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    public override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
}

// MARK: - Private methods
extension FabView {
    
    // MARK: - @objc funcs
    @objc private func fabTap() {
        guard let superV = superview else { return }
        if isShowingMenu {
            isShowingMenu = false
            delegate?.onFabTap(isShowingMenu: isShowingMenu)
            UIView.animate(withDuration: 0.3, animations: {
                superV.subviews.first(where: { $0 is FabMenuView})?.alpha = 0
                self.fabIcon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
                self.layoutIfNeeded()
            }, completion: { _ in
                self.hideMenu()
            })
        } else {
            isShowingMenu = true
            delegate?.onFabTap(isShowingMenu: isShowingMenu)
            self.showMenu()
            UIView.animate(withDuration: 0.3) {
                self.fabIcon.transform = .identity
            }
        }
    }
    
    // MARK: - Private funcs
    private func addAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.fabTap))
        fabButton.addGestureRecognizer(tap)
    }
    
    private func setShadow() {
        let shadowPath = UIBezierPath(roundedRect: fabButton.bounds, cornerRadius: 28)
        fabButton.layer.shadowPath = shadowPath.cgPath
        fabButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        fabButton.layer.shadowOpacity = 1
        fabButton.layer.shadowRadius = 4
        fabButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    private func showMenu() {
        guard let superV = superview else { return }
        let menuView = FabMenuView(dataSource: actionsList, delegate: self)
        superV.addSubview(menuView)
        menuView.setupLayout(fabtop: superV.subviews.first(where: { $0 is FabView })?.topAnchor)
        superV.bringSubviewToFront(menuView)
        superV.bringSubviewToFront(self)
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: superV.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: superV.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: superV.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: superV.bottomAnchor)
        ])
    }
    
    private func hideMenu() {
        guard let superV = superview else { return }
        superV.subviews.first(where: { $0 is FabMenuView})?.removeFromSuperview()
    }
}

// MARK: - ViewConfiguration
extension FabView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(fabButton)
        fabButton.addSubview(fabIcon)
    }
    
    func setupConstraints() {
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            //fabButton
            fabButton.topAnchor.constraint(equalTo: topAnchor),
            fabButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            fabButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            fabButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            fabButton.heightAnchor.constraint(equalToConstant: 56),
            fabButton.widthAnchor.constraint(equalToConstant: 56),
            
            //fabIcon
            fabIcon.centerYAnchor.constraint(equalTo: fabButton.centerYAnchor),
            fabIcon.centerXAnchor.constraint(equalTo: fabButton.centerXAnchor),
            fabIcon.widthAnchor.constraint(equalToConstant: 16),
            fabIcon.heightAnchor.constraint(equalToConstant: 16)
        ])

    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.fabIcon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
    }
}

// MARK: - FabViewDelegate
extension FabView: FabViewDelegate {
    func tapOnOption() {
        fabTap()
    }
}
