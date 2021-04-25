//
//  BottomAlert.swift
//  UIFramework
//
//  Created by Matheus Martins on 24/04/21.
//

import UIKit

public final class BottomAlert: UIView {
    // MARK: - Private properties
    @objc private let primaryAction: (() -> Void)
    @objc private let secondaryAction: (() -> Void)?
    
    private let bottomAlertBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerHStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            let image = UIImage(named: "xIcon", in: Bundle(for: FabView.self), with: nil)?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = .systemPink
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contentVStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let subtitleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let primaryActionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let secondaryActionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.backgroundColor = .white
        button.setTitleColor(.systemPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -  Initialization
    private init(model: BottomAlertModel, titleColor: UIColor) {
        self.primaryAction = model.primaryAction.action
        self.secondaryAction = model.secondaryAction?.action
        self.titleText.textColor = titleColor
        super.init(frame: .zero)
        setupViewConfiguration()
        setupInfos(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    public override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
    // MARK: - Prtivate methods
    private func setupInfos(with model: BottomAlertModel) {
        titleText.text = model.title
        subtitleText.text = model.subtitle
        descriptionText.text = model.description
        iconImage.image = model.icon
        primaryActionButton.setTitle(model.primaryAction.title, for: .normal)
        secondaryActionButton.setTitle(model.secondaryAction?.title, for: .normal)
        
        iconImage.isHidden = model.icon == nil
        closeButton.isHidden = !model.shouldShowCloseButton
        subtitleText.isHidden = model.subtitle == nil
        secondaryActionButton.isHidden = model.secondaryAction == nil
        closeButton.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        primaryActionButton.addTarget(self, action: #selector(handlerPrimaryAction), for: .touchUpInside)
        secondaryActionButton.addTarget(self, action: #selector(handlerSecondaryAction), for: .touchUpInside)
    }
    
    private func setShadow() {
        let shadowView: UIView = {
            let view = UIView(frame: bottomAlertBackground.frame)
            view.backgroundColor = .white
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = false
            return view
        }()
        
        let shadowPath = UIBezierPath(rect: shadowView.bounds)
        shadowView.layer.shadowPath = shadowPath.cgPath
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -4)
        addSubview(shadowView)
        bringSubviewToFront(bottomAlertBackground)
        sendSubviewToBack(shadowView)
    }
    
    @objc private func closeAlert() {
        BottomAlert.hide()
    }
    
    @objc private func handlerPrimaryAction() {
        primaryAction()
        BottomAlert.hide()
    }

    @objc private func handlerSecondaryAction() {
        secondaryAction?()
        BottomAlert.hide()
    }
    
    // MARK: - Public methods
    public static func hide() {
        guard let currentWindow = UIApplication.shared.keyWindow else { return }
        currentWindow.subviews.first(where: { $0.isKind(of: BottomAlert.self) })?.removeFromSuperview()
    }

    public static func show(model: BottomAlertModel, titleColor: UIColor = .black) {
        let bottomAlert = BottomAlert(model: model, titleColor: titleColor)
        bottomAlert.translatesAutoresizingMaskIntoConstraints = false
        guard let currentWindow = UIApplication.shared.keyWindow else { return }
        bottomAlert.transform = CGAffineTransform(translationX: currentWindow.bounds.midX, y: currentWindow.bounds.maxY)
        currentWindow.addSubview(bottomAlert)
        NSLayoutConstraint.activate([
            bottomAlert.topAnchor.constraint(equalTo: currentWindow.topAnchor),
            bottomAlert.bottomAnchor.constraint(equalTo: currentWindow.bottomAnchor),
            bottomAlert.leadingAnchor.constraint(equalTo: currentWindow.leadingAnchor),
            bottomAlert.trailingAnchor.constraint(equalTo: currentWindow.trailingAnchor)
        ])
        UIView.animate(withDuration: 0.3, animations: {
            bottomAlert.transform = .identity
            currentWindow.layoutIfNeeded()
        }) {  _ in
            bottomAlert.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
    }
    
    public static func removeAllBackDropViews() {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootController.view.subviews.filter { $0 is BottomAlert }.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - ViewConfiguration
extension BottomAlert: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(bottomAlertBackground)
        bottomAlertBackground.addSubview(headerHStackView)
        bottomAlertBackground.addSubview(closeButton)
        bottomAlertBackground.addSubview(contentVStackView)
        headerHStackView.addArrangedSubview(iconImage)
        headerHStackView.addArrangedSubview(titleText)
        contentVStackView.addArrangedSubview(subtitleText)
        contentVStackView.addArrangedSubview(descriptionText)
        contentVStackView.addArrangedSubview(primaryActionButton)
        contentVStackView.addArrangedSubview(secondaryActionButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomAlertBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAlertBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAlertBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6),
            
            headerHStackView.topAnchor.constraint(equalTo: bottomAlertBackground.topAnchor, constant: 24),
            headerHStackView.leadingAnchor.constraint(equalTo: bottomAlertBackground.leadingAnchor, constant: 24),
            headerHStackView.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            
            closeButton.topAnchor.constraint(equalTo: bottomAlertBackground.topAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: bottomAlertBackground.trailingAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            
            contentVStackView.topAnchor.constraint(equalTo: headerHStackView.bottomAnchor, constant: 16),
            contentVStackView.leadingAnchor.constraint(equalTo: bottomAlertBackground.leadingAnchor, constant: 24),
            contentVStackView.trailingAnchor.constraint(equalTo: bottomAlertBackground.trailingAnchor, constant: -24),
            contentVStackView.bottomAnchor.constraint(equalTo: bottomAlertBackground.bottomAnchor, constant: -30),
            
            primaryActionButton.heightAnchor.constraint(equalToConstant: 40),
            secondaryActionButton.topAnchor.constraint(equalTo: primaryActionButton.bottomAnchor, constant: 8),
            secondaryActionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureView() { }
}

