//
//  DataServices.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/28/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
class DataServices {
    static let shared: DataServices = DataServices()
    var result : [RequestObject] = []
    var access_token: String?
    var app_info: AppInfo?
    var posts: [Post] = []
    func getJSON() {
        guard let url = URL(string: "https://www.getpostman.com/collections/4f7efb3c7e9d556e924f") else { return}
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? JSON else  { return }
            guard let requestObject = jsonObject["requests"] as? Array<Any>  else { return }
            DispatchQueue.main.async {
                for requestObj in requestObject {
                    if let requestObjDict = requestObj as? JSON {
                        let reObj = RequestObject(json: requestObjDict)
                        self.result.append(reObj!)
                    }
                }
                NotificationCenter.default.post(name: NotificationKey.didFetchSuccess, object: nil)
            }
        }).resume()
    }
    
    func loginAuth(urlString: String, username: String, password: String) {
        let dict = ["username": username, "password": password] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            guard let url = URL(string: urlString) else { return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request){ data,response,error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? JSON else  { return }
                guard let access_token_key = jsonObject["access_token"] else {
                    return
                }
                DispatchQueue.main.async {
                    self.access_token = access_token_key as? String
                    NotificationCenter.default.post(name: NotificationKey.didLoginSuccess, object: nil)
                }
            }
            task.resume()
        }
    }
    
    func getAppInfo(urlString: String) {
        guard let url = URL(string: urlString) else { return}
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? JSON else  { return }
            DispatchQueue.main.async {
                let appinfo = AppInfo(json: jsonObject)
                self.app_info = appinfo
                NotificationCenter.default.post(name: NotificationKey.didFetchAppInforSuccess, object: nil)
            }
        }).resume()
    }
    
    func getTimelineJson(urlString: String) {
        guard let url = URL(string: urlString) else { return}
        var request = URLRequest(url: url)
        request.addValue("JWT eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? [String:AnyObject] else  { return }
            print(jsonObject)
        }).resume()

    }
    
}
