//
//  ProgressBarController.swift
//  UIFrameworkDemo
//
//  Created by Matheus Martins on 28/03/21.
//

import UIKit
import UIFramework

final class ProgressBarController: UIViewController {
    // MARK: - Private properties
    private let progressBar1 = ProgressBar(backgroundBarColor: .red, barColor: .blue)
    private let progressBar2 = ProgressBar(backgroundBarColor: .black, barColor: .orange)
    private let progressBar3 = ProgressBar(backgroundBarColor: .green, barColor: .black)
    private let progressBar4 = ProgressBar(backgroundBarColor: .gray, barColor: .purple)
    private let progressBar5 = ProgressBar(backgroundBarColor: .yellow, barColor: .red)
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Progress Bar"
        view.backgroundColor = .white
        addComponents()
        progressBar1.setProgressBar(goal: 100, done: 30)
        progressBar2.setProgressBar(goal: 100, done: 50)
        progressBar3.setProgressBar(goal: 100, done: 80)
        progressBar4.setProgressBar(goal: 100, done: 90)
        progressBar5.setProgressBar(goal: 100, done: 15)
    }
    
    
    // MARK: - Private methods
    private func addComponents() {
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            progressBar1.heightAnchor.constraint(equalToConstant: 30),
            progressBar2.heightAnchor.constraint(equalToConstant: 30),
            progressBar3.heightAnchor.constraint(equalToConstant: 30),
            progressBar4.heightAnchor.constraint(equalToConstant: 30),
            progressBar5.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        stack.addArrangedSubview(progressBar1)
        stack.addArrangedSubview(progressBar2)
        stack.addArrangedSubview(progressBar3)
        stack.addArrangedSubview(progressBar4)
        stack.addArrangedSubview(progressBar5)

        
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
