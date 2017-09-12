//
//  InstagramClient + Extensions.swift
//  Pods
//
//  Created by Admin on 26.08.17.
//
//

import Foundation
import Alamofire

extension InstagramClient {

  func encode(_ path: String?, parameters: [String: Any]) -> URL? {
    //swiftlint:disable:next line_length
    guard let path = path, let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: encodedPath) else {
      return nil
    }
    do {
      let initialRequest = URLRequest(url: url)
      let request = try URLEncoding(destination: .methodDependent).encode(initialRequest, with: parameters)
      return request.url
    } catch {
      print("\((error as NSError).localizedDescription)")
      return nil
    }
  }

}
