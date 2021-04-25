//
//  BottomAlertController.swift
//  UIFrameworkDemo
//
//  Created by Matheus Martins on 24/04/21.
//

import UIKit
import UIFramework

final class BottomAlertController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addButtons()
    }
    
    private func addButtons() {
        let variation1 = UIButton()
        let variation2 = UIButton()
        let variation3 = UIButton()
        let variation4 = UIButton()
        let variation5 = UIButton()
        
        variation1.translatesAutoresizingMaskIntoConstraints = false
        variation2.translatesAutoresizingMaskIntoConstraints = false
        variation3.translatesAutoresizingMaskIntoConstraints = false
        variation4.translatesAutoresizingMaskIntoConstraints = false
        variation5.translatesAutoresizingMaskIntoConstraints = false
        
        variation1.setTitle("Variation 1", for: .normal)
        variation2.setTitle("Variation 2", for: .normal)
        variation3.setTitle("Variation 3", for: .normal)
        variation4.setTitle("Variation 4", for: .normal)
        variation5.setTitle("Variation 5", for: .normal)
        
        view.addSubview(variation1)
        view.addSubview(variation2)
        view.addSubview(variation3)
        view.addSubview(variation4)
        view.addSubview(variation5)
        
        NSLayoutConstraint.activate([
            variation1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            variation1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            variation1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            variation1.heightAnchor.constraint(equalToConstant: 40),
            
            variation2.topAnchor.constraint(equalTo: variation1.bottomAnchor, constant: 24),
            variation2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            variation2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            variation2.heightAnchor.constraint(equalToConstant: 40),
            
            variation3.topAnchor.constraint(equalTo: variation2.bottomAnchor, constant: 24),
            variation3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            variation3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            variation3.heightAnchor.constraint(equalToConstant: 40),
            
            variation4.topAnchor.constraint(equalTo: variation3.bottomAnchor, constant: 24),
            variation4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            variation4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            variation4.heightAnchor.constraint(equalToConstant: 40),
            
            variation5.topAnchor.constraint(equalTo: variation4.bottomAnchor, constant: 24),
            variation5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            variation5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            variation5.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        variation1.addTarget(self, action: #selector(variations1), for: .touchUpInside)
        variation2.addTarget(self, action: #selector(variations2), for: .touchUpInside)
        variation3.addTarget(self, action: #selector(variations3), for: .touchUpInside)
        variation4.addTarget(self, action: #selector(variations4), for: .touchUpInside)
        variation5.addTarget(self, action: #selector(variations5), for: .touchUpInside)
    }

    @objc private func variations1() {
        BottomAlert.show(
            model: BottomAlertModel(
                icon: UIImage(named: "lock"),
                title: "Important Warning",
                subtitle: nil,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                shouldShowCloseButton: true,
                primaryAction: AlertAction(
                    title: "Label",
                    action: {
                        print("Tap on label")
                    }
                ),
                secondaryAction: nil),
            titleColor: .red
        )
    }
    
    @objc private func variations2() {
        BottomAlert.show(
            model: BottomAlertModel(
                icon: nil,
                title: "Important Warning",
                subtitle: nil,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                shouldShowCloseButton: true,
                primaryAction: AlertAction(
                    title: "Label",
                    action: {
                        print("Tap on label")
                    }
                ),
                secondaryAction: nil)
        )
    }
    
    @objc private func variations3() {
        BottomAlert.show(
            model: BottomAlertModel(
                icon: nil,
                title: "Important Warning",
                subtitle: nil,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                shouldShowCloseButton: false,
                primaryAction: AlertAction(
                    title: "Label",
                    action: {
                        print("Tap on label")
                    }
                ),
                secondaryAction: nil)
        )
    }
    
    @objc private func variations4() {
        BottomAlert.show(
            model: BottomAlertModel(
                icon: nil,
                title: "Important Warning",
                subtitle: "Very Important Warning",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                shouldShowCloseButton: false,
                primaryAction: AlertAction(
                    title: "Label",
                    action: {
                        print("Tap on label")
                    }
                ),
                secondaryAction: nil)
        )
    }
    
    @objc private func variations5() {
        BottomAlert.show(
               model: BottomAlertModel(
                   icon: nil,
                   title: "Important Warning",
                   subtitle: "Very Important Warning",
                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                   shouldShowCloseButton: true,
                   primaryAction: AlertAction(
                       title: "Label",
                       action: {
                           print("Tap on label")
                       }
                   ),
                   secondaryAction: AlertAction(
                       title: "Label 2",
                       action: {
                           print("Tap on label 2")
                       }
                   ))
           )
       }
}

