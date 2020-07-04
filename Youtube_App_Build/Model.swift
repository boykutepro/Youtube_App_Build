//
//  Model.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation

class Model {
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
            
            // Phân tích dữ liệu trả về
            
        }
        
        // Bắt đầu
        dataTask.resume()
    }
}
