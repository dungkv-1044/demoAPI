//
//  RequestObject.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/25/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>
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
        guard let jsonData = json["headerData"] as? JSON  else {
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
