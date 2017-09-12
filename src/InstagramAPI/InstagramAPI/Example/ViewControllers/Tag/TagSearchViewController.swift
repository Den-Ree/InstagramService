//
//  TagSearchViewController.swift
//  InstagramAPI
//
//  Created by Admin on 05.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class TagSearchViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
          tableView.tableFooterView = UIView.init(frame: .zero)
          tableView.estimatedRowHeight = 100
          tableView.rowHeight = UITableViewAutomaticDimension
        }
    }

    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    fileprivate var dataSource: [InstagramTag] = []
    fileprivate var searchActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search"
    }
}

extension TagSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagSearchCell") as! TagSearchCell
        let tag = dataSource[indexPath.row]
        cell.nameLabel.text?.append(String.hiddenSymbol + tag.name)
        cell.mediaCountLabel.text?.append(String.hiddenSymbol + String(format: "%li", tag.mediaCount))
        return cell
    }
}

extension TagSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //swiftlint:disable:next force_cast line_length
        let controller = storyboard.instantiateViewController(withIdentifier: "TagNameViewController") as! TagNameViewController
        controller.tagName = tag.name
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension TagSearchViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let router = InstagramTagRouter.search(query: searchText)
        InstagramClient().send(router, completion: { (tags: InstagramArrayResponse<InstagramTag>?, error: Error?) in
          if error == nil {
                if let data = tags?.data {
                self.dataSource = data
                  self.tableView.reloadData()
                }
            }
        })
    }
}
