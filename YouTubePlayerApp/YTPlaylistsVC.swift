//
//  YTPlaylistsVC.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/22/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import CoreData

class YTPlaylistsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var subscriptionId: String?
    var playlistId: String?
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: YTPlaylist.entityName())
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "subscriptionId == %@", self.subscriptionId!)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getPlaylists()
    }
    
    func getPlaylists() {
        YTRequestHelper.getPlaylists(subscriptionId!, success: {
           // debugPrint($0)
            self.tableView.reloadData()
            }, failure: { 
                
        })
    }
    
    //tableview datasource&delegate   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objects = fetchedResultsController.fetchedObjects {
            return objects.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! YTPlaylistCell
        if let objects = fetchedResultsController.fetchedObjects as? [YTPlaylist] {
            cell.setUpCellWithPlaylists(playlist: objects[indexPath.row])
        }
        YTRestKitManager.saveContext()
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Playlists"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let objects = fetchedResultsController.fetchedObjects as? [YTPlaylist] {
            self.playlistId = objects[indexPath.row].id!
        }
        performSegueWithIdentifier("Videos", sender: self)
    }
    
    //fetchResultsController
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    //segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Videos" {
            let videosVC = segue.destinationViewController as? YTVideosVC
            videosVC?.playlistId = self.playlistId
        }
    }
    
}
