//
//  FabCellModel.swift
//  UIFramework
//
//  Created by Matheus Martins on 05/04/21.
//

import UIKit

public struct FabCellModel {
    public let title: String
    public let icon: UIImage
    public let action: (() -> Void)
    public init(title: String, image: UIImage, action: @escaping () -> Void) {
        self.title = title
        self.icon = image
        self.action = action
    }
}

