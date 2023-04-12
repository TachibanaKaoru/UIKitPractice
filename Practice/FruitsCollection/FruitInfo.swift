//
//  FruitInfo.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation

struct FruitInfo: Hashable {
    static func == (lhs: FruitInfo, rhs: FruitInfo) -> Bool {
        return (lhs.id == rhs.id)
    }

    var name: String = ""
    var id: Int = 0

}
