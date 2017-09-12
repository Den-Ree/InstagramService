//
//  CommentTableViewController.swift
//  InstagramAPI
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {

    var mediaId: String?
    fileprivate var dataSource: [InstagramComment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let commentRouter = InstagramCommentRouter.getComments(mediaId: mediaId!)
        //swiftlint:disable:next line_length
        InstagramClient().send(commentRouter, completion: {( comments: InstagramArrayResponse<InstagramComment>?, error: Error?) in
          if error == nil {
              if let data = comments?.data {
                self.dataSource = data
                self.tableView.reloadData()
              }
          }
        })
    }
}
extension CommentTableViewController {

  // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        let comment = dataSource[indexPath.row]
        cell.commentLabel.text = comment.text
        cell.usernameLabel.text = comment.from.username
        cell.dateLabel.text = comment.createdDate.description
        return cell
    }
}
