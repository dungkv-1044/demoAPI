//
//  Constant.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/28/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
struct NotificationKey {
    static var didFetchSuccess = Notification.Name.init("didFetchDataFromURL")
    static var didLoginSuccess = Notification.Name.init("didLoginSuccess")
    static var didFetchAppInforSuccess = Notification.Name.init("didFetchAppInforSuccess")
}
