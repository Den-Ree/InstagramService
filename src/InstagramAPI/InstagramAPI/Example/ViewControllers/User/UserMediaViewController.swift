//
//  UserMediaViewController.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/5/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class UserMediaViewController: UIViewController {

    enum ControllerType {
        case unknown
        case recent(String?)
        case liked
    }
    var type: ControllerType = .unknown

    fileprivate var dataSource: [InstagramMedia?] = []
    fileprivate let kMaxPhotosInRaw = 4
    fileprivate let kPhotosSpacing: CGFloat = 1.0
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        switch type {
        case .recent(let userID):
            //TODO: fix spaghetti
            if let userID = userID {
                  //swiftlint:disable:next line_length
                  let userRecentRouter = InstagramUserRouter.getRecentMedia(.init(user: .id(userID), count: 10, minId: "10", maxId: "10"))
                  //swiftlint:disable:next line_length
                  InstagramClient().send(userRecentRouter, completion: { (media: InstagramArrayResponse<InstagramMedia>?, _: Error?) in
                  let media: [InstagramMedia]? = media?.data
                  self.dataSource = media!
                  self.collectionView.reloadData()
                })
            } else {
                //swiftlint:disable:next line_length
                let userRecentRouter = InstagramUserRouter.getRecentMedia(.init(user: .owner, count: 10, minId: "10", maxId: "10"))
                //swiftlint:disable:next line_length
                InstagramClient().send(userRecentRouter, completion: { (media: InstagramArrayResponse<InstagramMedia>?, _: Error?) in
                  let data: [InstagramMedia]? = media?.data

                  if let data = data {
                    self.dataSource = data
                  }

                  self.collectionView.reloadData()
                })
            }
            break

        case .liked:
            let userLikedRouter = InstagramUserRouter.getLikedMedia(.init(user: .owner, count: 10, maxLikeId: "10"))
            //swiftlint:disable:next line_length
            InstagramClient().send(userLikedRouter, completion: { (media: InstagramArrayResponse<InstagramMedia>?, _: Error?) in
                let data: [InstagramMedia]? = media?.data
              if let data = data {
                self.dataSource = data
              }
              self.collectionView.reloadData()
            })

            break

        default:
            break

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
}

extension UserMediaViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    //swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //swiftlint:disable:next line_length force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserMediaCell", for: indexPath) as! UserMediaCell
        let media = dataSource[indexPath.row]! as InstagramMedia
        cell.photoImageView.af_setImage(withURL: (media.image.lowResolution.url!))
        return cell
    }
}

extension UserMediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
    }
}

extension UserMediaViewController: UICollectionViewDelegateFlowLayout {
    //swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        //swiftlint:disable:next line_length
        let photoWidth = floor(screenWidth / CGFloat(kMaxPhotosInRaw) - kPhotosSpacing / CGFloat(kMaxPhotosInRaw) * kPhotosSpacing)
        return CGSize(width: photoWidth, height: photoWidth)
    }
    //swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kPhotosSpacing
    }
    //swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kPhotosSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, kPhotosSpacing * 2, 0)
    }
}
