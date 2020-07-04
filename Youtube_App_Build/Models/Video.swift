//
//  Video.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation

struct Video: Decodable {
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()

    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }

    // JSON sẽ được thông qua trong phương thức này, decoder là một tham chiếu đến file JSON đó
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Gán JSON["snippet"] vào snippetContainer
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Phân tích JSON title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Phân tích JSON description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Phân tích JSON publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Phân tích thumbnail (hình thu nhỏ)
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Phân tích Video ID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
        
    }
}
