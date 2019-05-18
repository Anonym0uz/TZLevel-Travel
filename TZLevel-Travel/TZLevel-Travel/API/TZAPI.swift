//
//  TZAPI.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 07.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit

class TZAPI: NSObject {
    
    private var datas: NSArray!
    
    func getItunesDatas(searchString: String!, completeHandler: @escaping (_ success: Bool, _ response: Any, _ error: String) -> ()) -> Void {
        let str = searchString.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=" + str
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                
                let jsonDecoded = try JSONDecoder().decode(TZiTunesData.self, from: data)
                print(jsonDecoded.resultCount!)
                
                completeHandler(true, jsonDecoded, "")
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    func getLastFmDatas(searchString: String!, completeHandler: @escaping (_ success: Bool, _ response: Any, _ error: String) -> ()) {
        // http://ws.audioscrobbler.com/2.0/?method=track.search&track=Believe&api_key=e3b4a240afbb4663f7ff19b4266bf40e&format=json
        //
        
        let str = searchString.replacingOccurrences(of: " ", with: "+")
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=\(str)&api_key=e3b4a240afbb4663f7ff19b4266bf40e&format=json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                
                let jsonDecoded = try JSONDecoder().decode(TZLastFMData.self, from: data)
                completeHandler(true, jsonDecoded, "")
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
}
