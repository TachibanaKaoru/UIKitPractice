//
//  FruitsCollectionViewController.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import Foundation
import UIKit

class FruitsCollectionViewController: UIViewController {

    private var collectionView: UICollectionView?

    private let normalHeader = "searchheader"
    private let smallHeader = "smallHeader"

    private var mainItemDataSource: UICollectionViewDiffableDataSource<Int, FruitInfo>? = nil

    // MARK: - setup

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        setupButtons()

        let aMainCollectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createMainLayout())
        aMainCollectionView.delegate = self
        view.addSubview(aMainCollectionView)

        aMainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        aMainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        aMainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        aMainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        aMainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

        aMainCollectionView.layer.borderColor = UIColor.red.cgColor
        aMainCollectionView.layer.borderWidth = 2.0

        collectionView = aMainCollectionView

        prepareDataSources()

        let fruit1 = FruitInfo(name: "apple", id: 1)
//        fruit1.name = "apple"
//        fruit1.id = 1

        let fruit2 = FruitInfo(name: "banana", id: 2)
//        fruit2.name = "banana"
//        fruit2.id = 2

        let fruit3 = FruitInfo(name: "orange", id: 3)
//        fruit3.name = "orange"
//        fruit3.id = 3

        let fruitinfos = [fruit1,fruit2,fruit3]

        var newSnapshot = NSDiffableDataSourceSnapshot<Int, FruitInfo>()

        newSnapshot.appendSections([0,1])

        newSnapshot.appendItems(
            [fruit1,fruit2],
            toSection: 1)
        newSnapshot.appendItems(
            [fruit3],
            toSection: 0)



    self.mainItemDataSource?.apply(newSnapshot)

    }

    private func setupButtons() {

        let button1 = UIButton(type: .close)
        button1.frame = CGRect(x: 10, y: 110, width: 50, height: 30)
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderWidth = 1.0
        button1.addTarget(self, action: #selector(press1(_:)), for: .primaryActionTriggered)
        view.addSubview(button1)


        let button2 = UIButton(type: .roundedRect)
        button2.frame = CGRect(x: 100, y: 110, width: 50, height: 30)
        button2.layer.borderColor = UIColor.red.cgColor
        button2.layer.borderWidth = 1.0
        button2.addTarget(self, action: #selector(press2(_:)), for: .primaryActionTriggered)
        view.addSubview(button2)

    }

    @objc
    func press1(_ button: UIButton) {
        print("111")

//        var newSnapshot = NSDiffableDataSourceSnapshot<Int, FruitInfo>()
        var currentSnapshot = self.mainItemDataSource?.snapshot()

        let sections = currentSnapshot?.sectionIdentifiers
        print("sections:\(sections)")

//        newSnapshot.appendSections([0,1])

        let fruit1 = FruitInfo(name: "りんご", id: 5)
        let fruit2 = FruitInfo(name: "ばなな", id: 6)
        let fruit3 = FruitInfo(name: "オレンジ", id: 7)

        currentSnapshot?.appendItems(
            [fruit1,fruit2],
            toSection: 1)
        currentSnapshot?.appendItems(
            [fruit3],
            toSection: 0)

        self.mainItemDataSource?.apply(currentSnapshot!)

//        self.mainItemDataSource?.apply(<#T##snapshot: NSDiffableDataSourceSectionSnapshot<FruitInfo>##NSDiffableDataSourceSectionSnapshot<FruitInfo>#>, to: <#T##Int#>)


    }

    @objc
    func press2(_ button: UIButton) {
        print("222")
    }


    private func setupCollectionView() {

    }

    // MARK: Data Source
    private func prepareDataSources() {

        let normalItemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FruitInfo> { cell, indexPath, playlistInfo in

            var config = FruitNormalContentConfiguration()
            config.mainTitle = playlistInfo.name
//            config.imageURL = playlistInfo.logoImageURL
//            config.id = playlistInfo.id

            cell.contentConfiguration = config
            cell.backgroundConfiguration = .clear()

        }

        let topItemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FruitInfo> { cell, indexPath, playlistInfo in

            var config = FruitTopContentConfiguration()
            config.mainTitle = playlistInfo.name
//            config.subtitleTitle = self.currentTopDeck?.name ?? ""
//            config.descriptionText = playlistInfo.description ?? ""

//            config.imageURL = playlistInfo.largestEyecatchImageURL

//            config.id = playlistInfo.id
//            config.primaryLight = playlistInfo.style?.primaryLight?.uiColor ?? UIColor.clear
//            config.primaryDark = playlistInfo.style?.primaryDark?.uiColor ?? UIColor.clear

            cell.contentConfiguration = config
            cell.backgroundConfiguration = .clear()

        }

        mainItemDataSource = UICollectionViewDiffableDataSource<Int, FruitInfo>(collectionView: collectionView!) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemInfo: FruitInfo) -> UICollectionViewCell? in

            let reg: UICollectionView.CellRegistration<UICollectionViewListCell, FruitInfo>
            switch indexPath.section {
            case 0:
                reg = topItemCellRegistration
            default:
                reg = normalItemCellRegistration

            }

            return collectionView.dequeueConfiguredReusableCell(
                using: reg,
                for: indexPath,
                item: itemInfo)

        }

        let searchNormalHeaderRegistration = UICollectionView.SupplementaryRegistration<FruitHeaderView>(elementKind: normalHeader) { supplementaryView, identifierstring, indexPath in

        }

        mainItemDataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in

            let head = collectionView.dequeueConfiguredReusableSupplementary(using: searchNormalHeaderRegistration, for: indexPath)

//            let targetDeck = self.targetDeck(i: indexPath.section)

            if indexPath.section == 0 {
                head.titleLabel.text = "bbbb"
            } else {
                head.titleLabel.text = "aaaaaa"

            }

            return head

        }

        collectionView?.dataSource = mainItemDataSource

    }

    // MARK: Layout
    private func createMainLayout() -> UICollectionViewCompositionalLayout {

        let inset: CGFloat = 0.0

        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in

            switch section {
            case 0:
                return self.topFruitLayout(layoutEnvironment, inset: inset)
            default:
                return self.normalFruitLayout(layoutEnvironment, inset: inset)
            }

        }
    }

    private func topFruitLayout(_ layoutEnvironment: NSCollectionLayoutEnvironment, inset: CGFloat) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(300.0),
            heightDimension: .absolute(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: itemSize,
            subitem: item,
            count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 40

        section.contentInsets = NSDirectionalEdgeInsets(
            top: -60,
            leading: inset,
            bottom: 40,
            trailing: inset
        )

        section.orthogonalScrollingBehavior = .continuous

        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(48.0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: normalHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [headerItem]

        return section
    }

    private func normalFruitLayout(_ layoutEnvironment: NSCollectionLayoutEnvironment, inset: CGFloat) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100.0),
            heightDimension: .absolute(60.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: itemSize,
            subitem: item,
            count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 40

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 100,
            leading: inset,
            bottom: 40,
            trailing: inset
        )

        section.orthogonalScrollingBehavior = .continuous

        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(48.0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: normalHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [headerItem]

        return section
    }

}

extension FruitsCollectionViewController: UICollectionViewDelegate {

}
