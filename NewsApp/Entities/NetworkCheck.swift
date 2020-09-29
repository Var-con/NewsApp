//
//  NetworkCheck.swift
//  NewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import Foundation
import Alamofire


struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
