//
//  FruitNormalContentConfiguration.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

struct FruitNormalContentConfiguration: UIContentConfiguration {

    var id: String = ""
    var mainTitle: String = ""
    var imageURL: URL? = nil

    func makeContentView() -> UIView & UIContentView {
        return FruitNormalContentView(configuration: self)
    }
    func updated(for state: UIConfigurationState) -> FruitNormalContentConfiguration {
        return self
    }

}

extension FruitNormalContentConfiguration: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.id == rhs.id)
    }
}
