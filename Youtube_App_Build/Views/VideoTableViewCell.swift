//
//  VideoTableViewCell.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func setCell(_ video: Video) {
        
        self.video = video
        
        guard self.video != nil else {
            return
        }
        
        // Set the title label
        self.titleLabel.text = video.title
        
        // Set the date label
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = dateFormatter.string(from: video.published)
        
        // Set the thumbnail
        guard self.video?.thumbnail != "" else {
            return
        }
        
        // Check cache before downloading data
        if let cachedData = cacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set the thumbnail ImageView
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        // Download the thumbnail
        let url = URL(string: self.video!.thumbnail)
        
        // Get the shared URLSession object
        let session = URLSession.shared
        //Creat a dataTask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                // Save the data in the cache
                cacheManager.setVideoCache(url!.absoluteString, data)
                
                //Check that the downloaded url matches the video thumbnail url that this cell is currently set to play
                if url!.absoluteString != self.video?.thumbnail {
                    //Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                //Create the image object
                let image = UIImage(data: data!)
                
                //Set the imageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        dataTask.resume()
    }

}
