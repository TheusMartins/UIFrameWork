//
//  ViewConfiguration.swift
//  UIFramework
//
//  Created by Matheus Martins on 28/03/21.
//

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureView()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}
