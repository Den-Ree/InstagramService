//
//  RootViewController.swift
//  InstagramAPI
//
//  Created by Admin on 08.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  fileprivate var isLogged = false

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Welcome!"
    let client = InstagramClient.init(clientId: "", clientSecret: "", clientRedirectUri: "")
    sendLogInRequest()
  }
}

// MARK: // UIWebViewDelegate
extension RootViewController: UIWebViewDelegate {
  //swiftlint:disable:next line_length
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if isLogged == false {
      tryLogInAccount(forURL: request.url!)
      return true
    } else if isLogged {
      return false
    } else {
      return true
    }
  }

  func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    print(error.localizedDescription)
  }
}

extension RootViewController {

  func receiveLoggedInstagramAccount(_ url: URL, completion: @escaping ((Error?) -> Void)) {
    //Receive logged in user from url
    isLogged = false

    InstagramClient().receiveLoggedUser(url, completion: { (loggedUserId: String?, error: Error?) -> Void in
      if loggedUserId != nil {
        self.isLogged = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //swiftlint:disable:next force_cast
        let controller = storyboard.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
        self.navigationController?.pushViewController(controller, animated: true)
        completion(nil)
      } else {
        completion(error)
      }
    })

  }

  func checkIsNeedToResendAuthorizationURL(for url: URL?) -> Bool {
    if let urlString = url?.absoluteString {
      print("check_url - \(url!.absoluteString) with \(urlString.contains("unknown_user"))")
      return urlString.contains("unknown_user")
    } else {
      return false
    }
  }
}

private extension RootViewController {

  func sendLogInRequest() {
      //swiftlint:disable:next line_length
      let request = URLRequest(url: InstagramClient.InstagramAuthorisationUrl().serverSideFlow!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
      print(request.url!)
      webView.loadRequest(request)
  }

  func tryLogInAccount(forURL url: URL) {
    receiveLoggedInstagramAccount(url, completion: { [weak self] (error) in
      guard let weakSelf = self else {
        return
      }
      if let error = error {
        print(error.localizedDescription)
      } else if weakSelf.isLogged {
        //TODO: Notify delegate
      } else if weakSelf.checkIsNeedToResendAuthorizationURL(for: url) {
        weakSelf.refreshRequest()
      }
    })
  }

  func refreshRequest() {
    HTTPCookieStorage.shared.cookieAcceptPolicy = .always
    sendLogInRequest()
  }

}
