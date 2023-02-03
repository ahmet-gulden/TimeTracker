//
//  Global.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A constants enum for global level.
enum Global {
    /// UI related constants.
    enum Margin {
        static let small: CGFloat = UIScreen.main.scale * 4.0
        static let normal: CGFloat = UIScreen.main.scale * 5.5

        static let horizontal: CGFloat = small
        static let vertical: CGFloat = normal
    }
}
