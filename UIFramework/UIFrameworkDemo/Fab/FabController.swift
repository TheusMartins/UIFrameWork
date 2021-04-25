//
//  FabController.swift
//  UIFrameworkDemo
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit
import UIFramework

final class FabController: UIViewController {
    // MARK: - Private properties
    private lazy var fab = FabView(actionsList: [
            FabCellModel(title: "Change background to yellow", image: UIImage(named: "lock")!, action: { [weak self] in
                self?.view.backgroundColor = .yellow
            }),
            FabCellModel(title: "Change background to blue", image: UIImage(named: "lock")!, action: { [weak self] in
                self?.view.backgroundColor = .blue
            }),
            FabCellModel(title: "Change background to orange", image: UIImage(named: "lock")!, action: { [weak self] in
                self?.view.backgroundColor = .orange
            }),
            FabCellModel(title: "Change background to purple", image: UIImage(named: "lock")!, action: { [weak self] in
                self?.view.backgroundColor = .purple
            })
        ], delegate: self
    )
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fab"
        view.backgroundColor = .white
        view.addSubview(fab)
        
        NSLayoutConstraint.activate([
            fab.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            fab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
    }
}

extension FabController: FabViewControllerHandlerDelegate {
    func onFabTap(isShowingMenu: Bool) {
        print(isShowingMenu ? "Menu is visible" : "Menu is not visible")
    }
}
