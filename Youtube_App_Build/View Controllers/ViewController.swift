//
//  ViewController.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModelDelegate {
    
    var model = Model()
    var videos = [Video] ()

    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
        model.delegate = self
        
        model.getVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Confirm that video was selected
        guard tableVIew.indexPathForSelectedRow != nil else {
            return
        }
        
        // Get a difference to the video that was tapped on
        let selectedVideo = videos[tableVIew.indexPathForSelectedRow!.row]
        
        // Get a difference to the detail viewcontroller
        let detailVC = segue.destination as! DetailViewController
        
        // Set the video property of the detail view controller
        detailVC.video = selectedVideo
        
    }
    
    // MARK: - Model Delegate Methods
    func videoFetched(_ videos: [Video]) {
        
        //Set the returned videos to our video property
        self.videos = videos
        
        // Refresh the tableView
        tableVIew.reloadData()
    }
    
    
    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableVIew.dequeueReusableCell(withIdentifier: Constants.VIDEOCELl_ID, for: indexPath) as? VideoTableViewCell
        
        // Configure the cell with data
        let video = self.videos[indexPath.row]
        
        cell?.setCell(video)
        
        // Return the cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

