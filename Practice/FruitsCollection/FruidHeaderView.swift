//
//  FruidHeaderView.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

class FruitHeaderView: UICollectionReusableView {

    var titleWord: String = ""

    let titleLabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        // TODO: focusguide

        titleLabel.frame = CGRect(x: 0, y: 0, width: 1000, height: 100)
        addSubview(titleLabel)
        titleLabel.text = titleWord

        // TODO: focus guide

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
