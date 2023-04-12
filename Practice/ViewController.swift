//
//  ViewController.swift
//  Practice
//
//  Created by Kaoru Tachibana on 2023/04/03.
//

import UIKit

struct MenuItem {
    let title: String
    let detail: String
    let itemFunction: () -> Void
}

struct MenuItemGroup {
    let title: String
    let groupItem: [MenuItem]
}

class ViewController: UIViewController {

    private let cellIdentifier: String = "menucell"
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private var menuItems: [MenuItemGroup] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        //背景をtableviewとあわせて目立たないようにする
        view.backgroundColor = UIColor.groupTableViewBackground

        prepareMenuItems()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }

    private func prepareMenuItems() {

        let menuA1 = MenuItem(
            title: "Fruit",
            detail: "DiffableDataSource",
            itemFunction: {
                print("A 1")
                let fruits = FruitsCollectionViewController()

                self.navigationController?.pushViewController(fruits, animated: true)
            }
        )

        let menuA2 = MenuItem(title: "Fruit", detail: "aa", itemFunction: {
            print("A 2")
        })

        let menuA3 = MenuItem(title: "A 3", detail: "aaa", itemFunction: {
            print("A 3")
        })

        let menuA4 = MenuItem(title: "A 4", detail: "a", itemFunction: {
            print("A 4")
        })

        let menuA5 = MenuItem(title: "A 5", detail: "aaaaa", itemFunction: {
            print("A 5")
        })

        let menuB1 = MenuItem(title: "B 1", detail: "bbb", itemFunction: {
            print("B 1")
        })

        let menuB2 = MenuItem(title: "B 2", detail: "bc", itemFunction: {
            print("B 2")
        })

        let menuC1 = MenuItem(title: "C 1", detail: "c", itemFunction: {
            print("C 1")
        })

        let menuC2 = MenuItem(title: "C 2", detail: "ccc", itemFunction: {
            print("C 2")
        })

        let menuC3 = MenuItem(title: "C 3", detail: "ccccc", itemFunction: {
            print("C 3")
        })

        let menuA = MenuItemGroup(title: "UICollectionView", groupItem: [menuA1,menuA2,menuA3,menuA4,menuA5])
        let menuB = MenuItemGroup(title: "UITableView", groupItem: [menuB1,menuB2])
        let menuC = MenuItemGroup(title: "UIImageView", groupItem: [menuC1,menuC2,menuC3])

        menuItems = [menuA,menuB,menuC]
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")

        let targetMenuGroup: MenuItemGroup = menuItems[indexPath.section]
        let targetMenuItem: MenuItem = targetMenuGroup.groupItem[indexPath.row]

        targetMenuItem.itemFunction()

        //switchで処理してくださいねー。
        //最初は、differable data souceをしたかったのです。

//        let fruits = FruitsCollectionViewController()
//
//        self.navigationController?.pushViewController(fruits, animated: true)
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let targetMenuGroup: MenuItemGroup = menuItems[section]

        return targetMenuGroup.groupItem.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let targetMenuGroup: MenuItemGroup = menuItems[section]

        return targetMenuGroup.title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        let targetMenuGroup: MenuItemGroup = menuItems[indexPath.section]
        let targetMenuItem: MenuItem = targetMenuGroup.groupItem[indexPath.row]

        cell.textLabel?.text = targetMenuItem.title
        cell.detailTextLabel?.text = targetMenuItem.detail

        return cell
    }
}
