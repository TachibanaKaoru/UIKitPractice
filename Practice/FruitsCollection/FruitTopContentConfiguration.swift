//
//  FruitTopContentConfiguration.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

struct FruitTopContentConfiguration: UIContentConfiguration {

    var id: String = ""
    var mainTitle: String = ""
    var descriptionText: String = "美味しい果物です。"
    var primaryLight: UIColor = UIColor.red
    var primaryDark: UIColor = UIColor.blue

    func makeContentView() -> UIView & UIContentView {
        return FruitTopContentView(configuration: self)
    }
    func updated(for state: UIConfigurationState) -> FruitTopContentConfiguration {
        return self
    }

    var gradientColor: UIColor {
        return UIColor(dynamicProvider: prov)
    }

    func prov(traitCollection: UITraitCollection) -> UIColor {
        switch traitCollection.userInterfaceStyle {
        case .light:
            return primaryLight
        case .dark:
            return primaryDark
        case .unspecified:
            return UIColor.clear
        @unknown default:
            return UIColor.clear
        }

    }

}

extension FruitTopContentConfiguration: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.id == rhs.id)
    }
}
