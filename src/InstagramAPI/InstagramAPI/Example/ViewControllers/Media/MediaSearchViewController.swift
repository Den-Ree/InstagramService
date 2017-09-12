//
//  MediaSearchViewController.swift
//  InstagramAPI
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MediaSearchCell"

class MediaSearchViewController: UICollectionViewController {

    var parameter: InstagramMediaRouter.SearchMediaParameter?
    fileprivate var dataSource: [InstagramMedia?] = []
    fileprivate let kMaxPhotosInRaw = 4
    fileprivate let kPhotosSpacing: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()

        let router = InstagramMediaRouter.search(parameter!)

        InstagramClient().send(router, completion: { (media: InstagramArrayResponse<InstagramMedia>?, error: Error?) in
          if error == nil {
              self.dataSource = (media?.data)!
              self.collectionView?.reloadData()
          }
        })

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension MediaSearchViewController {

  // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    //swiftlint:disable:next line_length
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //swiftlint:disable:next force_cast line_length
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MediaSearchCell
        let media = dataSource[indexPath.row]
        cell.imageView.af_setImage(withURL: (media?.image.lowResolution.url)!)
        return cell
    }
}

extension MediaSearchViewController : UICollectionViewDelegateFlowLayout {

  // MARK: - UICollectionViewDelegateFlowLayout
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
    //swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kPhotosSpacing * 2)
    }
}
