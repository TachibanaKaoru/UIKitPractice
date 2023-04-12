//
//  FruitTopContentView.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

/**
 フルーツセル。
 300x200用にレイアウトします。
 */
class FruitTopContentView: UIView, UIContentView {

    private let baseView = UIView(frame: .zero)

    private var mainImageView: UIImageView = UIImageView(frame: CGRect.zero)

    private var mainTitleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()

    private var gradientLayer = CAGradientLayer()

    var configuration: UIContentConfiguration {
        didSet {

            if let conf = configuration as? FruitTopContentConfiguration {

                if let oldConf = oldValue as? FruitTopContentConfiguration {

                    if oldConf == conf {
                        // do nothing
                    } else {
                        cancelConfig()
                        updateConfig()
                    }
                } else {
                    updateConfig()
                }
            }
        }
    }

    init(configuration: UIContentConfiguration) {

//        let cellCornerRadius: CGFloat = 20.0

        self.configuration = configuration
        super.init(frame: .zero)
//        self.backgroundColor = UIColor.green

        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0

        // baseView
        let baseColor = UIColor.clear
        addSubview(baseView)
        baseView.backgroundColor = baseColor

        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        // mainImageView
        addSubview(mainImageView)
        mainImageView.frame = CGRect(x: 250, y: 0, width: 50, height: 50)

//        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.image = UIImage(systemName: "applelogo")

        // debug
        mainImageView.layer.borderColor = UIColor.yellow.cgColor
        mainImageView.layer.borderWidth = 1.0

        mainTitleLabel.frame = CGRect(x: 50, y: 20, width: 200, height: 20)
        mainTitleLabel.textAlignment = .left
        mainTitleLabel.numberOfLines = 1
        mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        mainTitleLabel.textColor = UIColor.blue

        addSubview(mainTitleLabel)

        descriptionLabel.frame = CGRect(x: 50, y: 50, width: 200, height: 50)

        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 10.0)

        addSubview(descriptionLabel)

        gradientLayer.colors = [UIColor.systemRed.cgColor, UIColor.clear.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

//        baseView.layer.addSublayer(gradientLayer)
//        mainImageView.layer.addSublayer(gradientLayer)
        baseView.layer.addSublayer(gradientLayer)
//        self.layer.addSublayer(gradientLayer)

        updateConfig()

    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        //TODO: UIContentView だとフォーカスがとれないので、CollectionViewCellで作り直した方が良さそう。
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateConfig() {

        if let conf = configuration as? FruitTopContentConfiguration {
            mainTitleLabel.text = conf.mainTitle
            descriptionLabel.text = conf.descriptionText

        }
    }

    func cancelConfig() {

    }

}
