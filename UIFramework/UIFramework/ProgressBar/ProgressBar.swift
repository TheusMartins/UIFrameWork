//
//  ProgressBar.swift
//  UIFramework
//
//  Created by Matheus Martins on 28/03/21.
//

import UIKit

public final class ProgressBar: UIView {
    // MARK: - Private properties
    private var widhtBar: NSLayoutConstraint?
    
    private let progressBar: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Initialization
    public init(backgroundBarColor: UIColor, barColor: UIColor, exceedBarColor: UIColor) {
        super.init(frame: .zero)
        setupViewConfiguration()
        setColors(backgroundBarColor: backgroundBarColor, barColor: barColor, exceedBarColor: exceedBarColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setColors(backgroundBarColor: UIColor, barColor: UIColor, exceedBarColor: UIColor) {
        self.backgroundColor = backgroundBarColor
        progressBar.backgroundColor = barColor
    }
    
    // MARK: - Public methods
    public func setProgressBar(goal: Double, done: Double) {
        let percentValue = goal / 100
        let progressValue = percentValue == 0 ? 0 : done / percentValue
        let viewSize = self.bounds.width / 100
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.widhtBar?.constant = CGFloat(progressValue * Double(viewSize))
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        }
    }
}
extension ProgressBar: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(progressBar)
    }
    
    func setupConstraints() {
        for view in subviews { view.translatesAutoresizingMaskIntoConstraints = false }
        
        widhtBar = progressBar.widthAnchor.constraint(equalToConstant: 0)
        
        guard let widhtBar = widhtBar else { return }
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            widhtBar
        ])
    }
    
    func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
}

