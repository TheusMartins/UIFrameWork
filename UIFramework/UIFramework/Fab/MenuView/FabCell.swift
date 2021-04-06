//
//  FabCell.swift
//  UIFramework
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit

final class FabCell: UITableViewCell {
    // MARK: - Private properties
    private let actionTile: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private var actionIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Overrides
    override var reuseIdentifier: String {
        return "FabCell"
    }
    
    // MARK: -  Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Non private funcs
    func setupInfos(with model: FabCellModel) {
        actionTile.text = model.title
        actionIcon.image = model.icon
    }
}

// MARK: - ViewConfiguration
extension FabCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(actionTile)
        addSubview(actionIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            actionTile.centerYAnchor.constraint(equalTo: actionIcon.centerYAnchor),
            actionTile.trailingAnchor.constraint(equalTo: actionIcon.leadingAnchor, constant: -12),
            
            actionIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            actionIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            actionIcon.widthAnchor.constraint(equalToConstant: 40),
            actionIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}

