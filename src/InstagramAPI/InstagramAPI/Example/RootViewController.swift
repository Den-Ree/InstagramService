//
//  ViewController.swift
//  InstagramAPI
//
//  Created by Denis on 12.12.16.
//  Copyright © 2016 ConceptOffice. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet fileprivate weak var webView: UIWebView!
    fileprivate var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome!"

        sendLogInRequest()
    }
}


//MARK: External
extension RootViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url , isLoggedIn == false {
            tryLogInAccount(forURL: url)
            return true
        } else if isLoggedIn {
            return false
        } else {
            return true
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
    
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        handle(logInError: error)
    }
}


extension RootViewController {
    var authorizationURL: URL? {
        return InstagramManager.shared.authorizationURL()
    }
    
    func receiveLoggedInInstagramAccount(_ url: URL, completion: @escaping ((Error?)->())) {
        //Receive logged in user from url
        isLoggedIn = false
        
        InstagramManager.shared.receiveLoggedInUser(url) { (user: Instagram.User?, error) -> () in
            if let instagramAccount = user, let objectId = instagramAccount.objectId , objectId.characters.count > 0 {
                self.isLoggedIn = true
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
                self.navigationController?.pushViewController(controller, animated: true)
                completion(nil)
            } else {
                completion(error)
            }
        }
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
        if let authorizationURL = authorizationURL {
            //isStartedLogin = true
            let request = URLRequest(url: authorizationURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            webView.loadRequest(request)
        }
    }
    
    func tryLogInAccount(forURL url: URL) {
        receiveLoggedInInstagramAccount(url, completion: { [weak self] (error) in
            guard let weakSelf = self else {
                return
            }
            if let error = error as NSError? {
                weakSelf.handle(logInError: error)
            } else if weakSelf.isLoggedIn {
                //TODO: Notify delegate
            } else if weakSelf.checkIsNeedToResendAuthorizationURL(for: url) {
                weakSelf.refreshRequest()
            }
        })
    }
    func handle(logInError error: Error) {
        let error = error as NSError
        print("\(error.localizedDescription)")
    }
    
    func refreshRequest() {
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        sendLogInRequest()
    }
}
