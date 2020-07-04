//
//  Model.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func videoFetched(_ videos: [Video])
}

class Model {
    
    var delegate: ModelDelegate?
    
    func getVideos() {
        // Tạo 1 URL
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // Gọi một URLSession
        let session = URLSession.shared
        
        // Datatask nhận dữ liệu từ URLSession
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Kiểm tra xem còn lỗi không
            if error != nil || data == nil {
                return
            }
            
            do  {
                // Phân tích dữ liệu trả về
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil {
                    
                    DispatchQueue.main.async {
                        // Call the "videosFetched" methodof the delegate
                        self.delegate?.videoFetched(response.items!)
                    }
                   
                }
                
                //Dump: xuất mọi thứ bên trong response lên console để thấy nó có hoạt động hay không
                dump(response)
            } catch {
                
            }
            
        }
        
        // Bắt đầu
        dataTask.resume()
    }
}
