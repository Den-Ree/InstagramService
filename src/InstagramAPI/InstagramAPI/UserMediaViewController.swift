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

    fileprivate var dataSource:[InstagramMedia?] = []
    fileprivate let kMaxPhotosInRaw = 4
    fileprivate let kPhotosSpacing: CGFloat = 1.0
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .recent(let userID):
            InstagramManager.shared.mediaService.sendMediaRequest(forUser: userID, count: 20, maxId: "10") { [weak self](instagramMedia, paginationInfo, error) in
                if let media = instagramMedia {
                    self?.dataSource = media
                    self?.collectionView.reloadData()
                }
            }
            break
            
        case .liked:
            InstagramManager.shared.mediaService.sendMediaLikedRequest(count: 50, maxLikeID: "300") { [weak self](instagramMedia, paginationInfo, error) in
                if let media = instagramMedia {
                    self?.dataSource = media
                    self?.collectionView.reloadData()
                }
            }
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserMediaCell", for: indexPath) as! UserMediaCell
        let media = dataSource[indexPath.row]! as InstagramMedia
        cell.photoImageView.af_setImage(withURL: (media.image?.lowResolutionURL?.URL)!)
        return cell
    }
}

extension UserMediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
    }
}

extension UserMediaViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let photoWidth = floor(screenWidth / CGFloat(kMaxPhotosInRaw) - kPhotosSpacing / CGFloat(kMaxPhotosInRaw) * kPhotosSpacing)
        return CGSize(width: photoWidth, height: photoWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kPhotosSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kPhotosSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, kPhotosSpacing * 2, 0)
    }
}
