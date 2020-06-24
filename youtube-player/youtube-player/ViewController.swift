//
//  ViewController.swift
//  youtube-player
//
//  Created by Dillon on 6/21/20.
//  Copyright © 2020 ddonco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set self as data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // set self as the delegate of the model
        model.delegate = self
        
        model.getVideos()
    }
    
    // MARK: - Model Delegate Methods
    
    func videosFetched(_ videos: [Video]) {
        
        // set the returned videos to the video property
        self.videos = videos
        
        // refresh the tableview
        tableView.reloadData()
    }

    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath)
        
        // configure the cell with the data
        // get video title
        let title = self.videos[indexPath.row].title
        
        cell.textLabel?.text = title
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

