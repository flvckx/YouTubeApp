//
//  YTVideosVC.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/23/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class YTVideosVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let playlistKind = "youtube#searchResult"
    let deletedVideo = "Deleted video"
    
    var playlistId: String?
    var isVideoFromSearch: Bool?
    var videoId: String?
    var videoTitle: String?
    var searchInfo: String?
    var etag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getVideos()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
            if self.isMovingFromParentViewController() {
            let context = YTRestKitManager.sharedManager.managedObjectContext
            if let objects = fetchedResultsController.fetchedObjects as? [YTSearchedVideo] {
                if objects.count > 0 {
                    for object in objects {
                        if object.kind == self.playlistKind {
                            context.deleteObject(object as NSManagedObject)
                        }
                    }
                    YTRestKitManager.saveContext()
                }
            }
        }
    }

    func getVideos() {
        if let _ = playlistId {
            YTRequestHelper.getVideoItems(self.playlistId!, success: {
                self.tableView.reloadData()
            }) {
            }
        } else if let _ = searchInfo {
            YTRequestHelper.searchVideos(self.searchInfo!, success: {
                self.tableView.reloadData()
                }, failure: { 
                    
            })
        }
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        var fetchRequest = NSFetchRequest(entityName: YTVideo.entityName())
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        if let _ = self.playlistId {
            fetchRequest.predicate = NSPredicate(format: "(playlistId == %@) AND (title != %@)", self.playlistId!, self.deletedVideo)
        } else if let _ = self.isVideoFromSearch {
            fetchRequest = NSFetchRequest(entityName: YTSearchedVideo.entityName())
            fetchRequest.predicate = NSPredicate(format: "kind == %@", self.playlistKind)
        }
        fetchRequest.sortDescriptors = [sortDescriptor]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: YTRestKitManager.sharedManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        } catch {
            debugPrint("Saving context error: \(error)")
        }
        return controller
    }()
    
    //tableview datasource/delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objects = fetchedResultsController.fetchedObjects {
            return objects.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! YTVideosCell
        if (self.isVideoFromSearch == nil) {
            if let objects = fetchedResultsController.fetchedObjects as? [YTVideo]{
                cell.setUpCellWithVideos(video: objects[indexPath.row])
            }
        } else {
            if let objects = fetchedResultsController.fetchedObjects as? [YTSearchedVideo]{
                cell.setUpCellWithSearchedVideos(video: objects[indexPath.row])
            }
        }
        YTRestKitManager.saveContext()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let objects = fetchedResultsController.fetchedObjects as? [YTVideo] {
            self.videoId = objects[indexPath.row].id
            self.videoTitle = objects[indexPath.row].title
        }
        if let objects = fetchedResultsController.fetchedObjects as? [YTSearchedVideo] {
            self.videoId = objects[indexPath.row].id
            self.videoTitle = objects[indexPath.row].title
        }
        performSegueWithIdentifier("Play", sender: self)
    }
    
    //fetchResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Play" {
            let playerVC = segue.destinationViewController as? YTPlayer
            playerVC?.videoId = self.videoId
            playerVC?.vTitle = self.title
        }
    }
}