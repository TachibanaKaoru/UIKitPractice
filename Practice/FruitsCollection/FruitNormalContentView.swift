//
//  FruitNormalContentView.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

class FruitNormalContentView: UIView, UIContentView {

    private var mainImageView: UIImageView = UIImageView(frame: CGRect.zero)
    private var bottomTitleLabel: UILabel = UILabel()

    var configuration: UIContentConfiguration {
        didSet {

            if let conf = configuration as? FruitNormalContentConfiguration {

                if let oldConf = oldValue as? FruitNormalContentConfiguration {

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

        self.configuration = configuration
        super.init(frame: .zero)
        self.backgroundColor = UIColor.clear

        let baseColor = UIColor.clear
        let baseView = UIView(frame: .zero)
        addSubview(baseView)
        baseView.backgroundColor = baseColor

        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(mainImageView)
        mainImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)

        // TODO: これをtrueにすると、adjustsImageWhenAncestorFocusedのフォーカス範囲が狭まる。でもfalseだとcornerRadiusが効かない。
        mainImageView.clipsToBounds = false
        mainImageView.layer.cornerRadius = 16.0
        mainImageView.contentMode = .scaleAspectFit
//        mainImageView.adjustsImageWhenAncestorFocused = true

         mainImageView.layer.borderColor = UIColor.green.cgColor
         mainImageView.layer.borderWidth = 5.0

        addSubview(bottomTitleLabel)

        bottomTitleLabel.frame = CGRect(x: 0, y: 330, width: 320, height: 28)

        bottomTitleLabel.textAlignment = .center
        bottomTitleLabel.numberOfLines = 1
        bottomTitleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)

        bottomTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        //TODO: 別のとこにつけてー
        bottomTitleLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor).isActive = true
        bottomTitleLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor).isActive = true
        bottomTitleLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor).isActive = true

        if traitCollection.userInterfaceStyle == .dark {
            bottomTitleLabel.textColor = UIColor.white

        } else if traitCollection.userInterfaceStyle == .light {
            bottomTitleLabel.textColor = UIColor.black

        }

        bottomTitleLabel.backgroundColor = UIColor.clear

        updateConfig()

    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        //TODO: UIContentView だとフォーカスがとれないので、CollectionViewCellで作り直した方が良さそう。
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateConfig() {

        if let conf = configuration as? FruitNormalContentConfiguration {
            bottomTitleLabel.text = conf.mainTitle
//            mainImageView.loadMovieImage(with: conf.imageURL)

        }
    }

    func cancelConfig() {
//        mainImageView.cancelLoading()
//        mainImageView.image = nil

    }

}
