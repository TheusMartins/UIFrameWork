//
//  ViewController.swift
//  UIFrameworkDemo
//
//  Created by Matheus Martins on 28/03/21.
//

import UIKit

enum Components {
    case progressBar
    case fab
}

final class ComponentList: UIViewController {
    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private let dataSource: [Components] = [.progressBar, .fab]
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = tableView
    }
}

extension ComponentList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .progressBar: navigationController?.pushViewController(ProgressBarController(), animated: true)
        case .fab: navigationController?.pushViewController(FabController(), animated: true)
        }
    }
}

extension ComponentList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell.init(style: .default, reuseIdentifier: "DefaultCell")
        cell.selectionStyle = .none
        switch dataSource[indexPath.row] {
        case .progressBar: cell.textLabel?.text = "ProgressBar"
        case .fab: cell.textLabel?.text = "Fab"
        }
        return cell
    }
}
