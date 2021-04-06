//
//  SelfSizedTableView.swift
//  UIFramework
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit

final class SelfSizedTableView: UITableView {
    
    // MARK: - Overrides
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

