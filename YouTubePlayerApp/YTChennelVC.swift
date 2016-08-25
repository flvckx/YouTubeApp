//
//  YTChennelVC.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import CoreData

class YTChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var searchActive : Bool = false
    var searchInfo: String?
    var subscriptionId: String?
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: YTChannel.entityName())
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
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
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getChannels()
    }
    
    func getChannels() {
        YTRequestHelper.getSubscription({ 
            self.tableView.reloadData()
            }) { 
                
        }
    }
    
    //searchBar
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        debugPrint("begin")
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        debugPrint("search")
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        debugPrint("cancel")
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        debugPrint("clicked")
        if let _ = self.searchBar.text {
            self.searchInfo = self.searchBar.text
            performSegueWithIdentifier("searchVideo", sender: self)
        }
        searchActive = false;
    }
    
    //tableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objects = fetchedResultsController.fetchedObjects {
            return objects.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! YTChannelCell
        if let objects = fetchedResultsController.fetchedObjects as? [YTChannel]{
            cell.setUpCellWithChannels(channel: objects[indexPath.row])
        }
        YTRestKitManager.saveContext()
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Subscriptions"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let objects = fetchedResultsController.fetchedObjects as? [YTChannel] {
            self.subscriptionId = objects[indexPath.row].id!
        }
        performSegueWithIdentifier("Playlist", sender: self)
    }
    
    //fetchResultsController
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Playlist" {
            let playlistVC = segue.destinationViewController as! YTPlaylistsVC
            playlistVC.subscriptionId = self.subscriptionId
        }
        if segue.identifier == "searchVideo" {
            let videoVC = segue.destinationViewController as! YTVideosVC
            videoVC.searchInfo = self.searchInfo
            videoVC.isVideoFromSearch = true
        }
    }
}
