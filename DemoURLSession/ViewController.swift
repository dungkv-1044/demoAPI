//
//  ViewController.swift
//  DemoURLSession
//
//  Created by Khuat Van Dung on 8/25/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJSON() {
        guard let url = URL(string: "https://www.getpostman.com/collections/4f7efb3c7e9d556e924f") else { return}
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? Dictionary<AnyHashable,Any> else  { return }
            print(jsonObject)
//            guard let actors = jsonObject["actors"] as? Array<Any>  else { return }
//            var result : [Person] = []
//            for actor in actors {
//                if let actorDict = actor as? Dictionary<AnyHashable,Any> {
//                    let person = Person(dictionary: actorDict)
//                    result.append(person)
//                }
//            }
//            self._person = result
        }).resume()
    }
}


