//
//  ServiceManager.swift
//  Kitten
//
//  Created by Ravi on 10/06/18.
//  Copyright © 2018 Ravi. All rights reserved.
//

import Foundation

final class ServiceManager: NSObject {
    
    class func loadRequest(_ requestUrl: URL, completion:@escaping (_ data: Data?, _ error: Error?)->()) {
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            completion(data, error)
            }.resume()
    }
    
    class func fetchServiceData(_ completion:@escaping (_ data: [Cat]?, _ error: Error?)->()) {
        let resource = Request()
        let url = resource.url
        ServiceManager.loadRequest(url) { (data, error) in
            guard let data = data else { completion(nil, error)
                return
            }
            
            ServiceManager.parse(data, completion: { (cats, error) in
                completion(cats, nil)
            })
        }
    }
    
    class func fecthImage(_ url: URL, completion:@escaping (_ data: Data?, _ error: Error?)->()) {
        ServiceManager.loadRequest(url) { (data, error) in
            completion(data, error)
        }
    }
    
    class func parse(_ data: Data, completion:@escaping (_ data: [Cat]?, _ error: Error?)->()) {
        let parser = Parser()
        parser.parse(data, with: { (cats, error) in
            completion(cats, nil)
        })
    }
}
