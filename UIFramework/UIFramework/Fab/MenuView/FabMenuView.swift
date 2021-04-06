//
//  FabMenuView.swift
//  UIFramework
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit

protocol FabViewDelegate: class {
    func tapOnOption()
}

final class FabMenuView: UIView {
    // MARK: - Private properties
    private var fabTop: NSLayoutYAxisAnchor?
    private weak var delegate: FabViewDelegate?
    private lazy var tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        tableView.layer.cornerRadius = 4
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FabCell.self, forCellReuseIdentifier: "FabCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let dataSource: [FabCellModel]
    
    // MARK: - Initialization
    init(dataSource: [FabCellModel], delegate: FabViewDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - public funcs
    func setupLayout(fabtop: NSLayoutYAxisAnchor?) {
        fabTop = fabtop
        setupViewConfiguration()
    }
    
    private func doAction(completion: @escaping () -> Void) {
        delegate?.tapOnOption()
        completion()
    }
}

// MARK: - UITableViewDelegate
extension FabMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.row].action()
        delegate?.tapOnOption()
    }
}

// MARK: - UITableViewDataSource
extension FabMenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FabCell") as? FabCell else {
            return UITableViewCell()
        }
        cell.setupInfos(with: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height * CGFloat(tableView.numberOfRows(inSection: 0)) )

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
}

// MARK: - ViewConfiguration
extension FabMenuView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        guard let fabTop = fabTop else { return }
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: fabTop)
        ])
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        backgroundColor = UIColor.white.withAlphaComponent(0.9)
        tableView.reloadData()
    }
}

