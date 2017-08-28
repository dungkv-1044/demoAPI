//
//  RequestObject.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/25/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
typealias JSON = [String:AnyObject]
struct RequestObject {
    var id: String?
    var headers: String?
    var headerData: [HeaderData] = []
    var url: String?
    var name: String?
    var time: TimeInterval?
    init?(json: JSON) {
        self.id = json["id"] as? String
        self.headers = json["headers"] as? String
        self.url = json["url"] as? String
        self.name = json["name"] as? String
        self.time = json["time"] as? TimeInterval
        guard let jsonData = json["headerData"] as? [JSON] else {
            return
        }
        for jsonHData in jsonData {
            if let hData = HeaderData(json: jsonHData) {
                self.headerData.append(hData)
            }
        }
    }
}
struct HeaderData {
    var key: String?
    var value: String?
    var description: String?
    var enabled: Bool?
    init?(json : JSON) {
        self.key = json["key"] as? String
        self.value = json["value"] as? String
        self.description = json["value"] as? String
        self.enabled = json["enabled"] as? Bool
    }
}
struct AppInfo {
    var current_version: String?
    var status: String?
    var update_required: Bool?
    init?(json: JSON) {
        self.current_version = json["current_version"] as? String
        self.status = json["status"] as? String
        self.update_required = json["update_required"] as? Bool
    }
}

struct Post {
    var comment_cnt: Int?
    var created_at: String?
    var id: Int?
    var like_cnt: Int?
    var share_cnt: Int?
    var status: String?
    var type: String?
    var updated_at: String?
    var user_post: UserInfo?
    
    init?(json: JSON) {
        self.comment_cnt = json["comment_cnt"] as? Int
        self.created_at = json["created_at"] as? String
        self.id = json["id"] as? Int
        self.like_cnt = json["like_cnt"] as? Int
        self.share_cnt = json["share_cnt"] as? Int
        self.status = json["status"] as? String
        self.type = json["type"] as? String
        self.updated_at = json["updated_at"] as? String
        guard let jsonData = json["user_post"] as? JSON else {
            return
        }
        if let user = UserInfo(json: jsonData) {
            self.user_post = user
        }
    }
}
struct UserInfo {
    var id: Int?
    
    init?(json: JSON) {
        self.id = json["id"] as? Int
    }
}
