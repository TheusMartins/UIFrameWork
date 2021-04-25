//
//  BottomAlertModel.swift
//  UIFramework
//
//  Created by Matheus Martins on 24/04/21.
//

import UIKit

public struct AlertAction {
    public var action: (() -> Void)
    public var title: String
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

public struct BottomAlertModel {
    public var icon: UIImage?
    public var title: String
    public var subtitle: String?
    public var description: String
    public var shouldShowCloseButton: Bool
    public var primaryAction: AlertAction
    public var secondaryAction: AlertAction?
    
    public init(
        icon: UIImage?,
        title: String,
        subtitle: String?,
        description: String,
        shouldShowCloseButton: Bool,
        primaryAction: AlertAction,
        secondaryAction: AlertAction?
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.shouldShowCloseButton = shouldShowCloseButton
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

