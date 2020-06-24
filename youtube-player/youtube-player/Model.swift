//
//  Model.swift
//  youtube-player
//
//  Created by Dillon on 6/21/20.
//  Copyright © 2020 ddonco. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(_ videos:[Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos() {
        // create URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else{
            return
        }
        
        // get a URLSession object
        let session = URLSession.shared
        
        // get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            // check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            do {
                // parse the data into video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                //
                let response = try decoder.decode(Response.self, from: data!)
            
                if response.items != nil {
                    // asynchronously run videos fetching
                    DispatchQueue.main.async {
                        // call the videosFetched method of the delegate
                        self.delegate?.videosFetched(response.items!)
                    }
                }
            }
            catch {
                
            }
        }
        
        // kick off the task
        dataTask.resume()
    }
}
