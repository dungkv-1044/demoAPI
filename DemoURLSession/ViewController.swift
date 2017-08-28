//
//  ViewController.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/25/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    
    var requestObject: [RequestObject]? {
        willSet {
            self.requestObject = DataServices.shared.result
        }
        didSet {
            print(requestObject)
        }
    }
    var appInfo: AppInfo? {
        willSet {
            self.appInfo = DataServices.shared.app_info
        }
        didSet {
           print(appInfo?.current_version)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.shared.getJSON()
        registerNotification()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NotificationKey.didFetchSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginSuccess(_:)), name: NotificationKey.didLoginSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFetchAppInfo(_:)), name: NotificationKey.didFetchAppInforSuccess, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        self.requestObject = DataServices.shared.result
    }
    func handleLoginSuccess(_ notification: Notification) {
        print(DataServices.shared.access_token!)
    }
    
    func handleFetchAppInfo(_ notification: Notification) {
        self.appInfo = DataServices.shared.app_info
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        let url = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1/user/login"
        let username = "ltranframgia@framgia.com"
        let password = "12345678"
        DataServices.shared.loginAuth(urlString: url, username: username, password: password)
    }
    @IBAction func timelineTapped(_ sender: UIButton) {
        guard let url = requestObject?[0].name else {
            return
        }
        DataServices.shared.getTimelineJson(urlString: url)
    }
    @IBAction func appinfoTapped(_ sender: UIButton) {
        guard let url = requestObject?[2].name else {
            return
        }
        DataServices.shared.getAppInfo(urlString: url)
    }
    
}


