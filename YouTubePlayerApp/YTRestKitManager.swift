//
//  YTRestKitManager.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import RestKit

let baseURL = (NSBundle.mainBundle().objectForInfoDictionaryKey("APP_SERVER") as! String)

class YTRestKitManager: NSObject {
    static let sharedManager = YTRestKitManager()
    var managedObjectContext: NSManagedObjectContext {
        get {
            return RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
        }
    }
    
    override init() {
        super.init()
        let pathToPersistentStore = "\(RKApplicationDataDirectory())/YouTubePlayerDemoApp.sqlite"
        RKlcl_configure_by_name("RestKit/Network", RKlcl_vTrace.rawValue);
        let managedObjectStore = RKManagedObjectStore(managedObjectModel: NSManagedObjectModel.mergedModelFromBundles(nil))
        managedObjectStore.createPersistentStoreCoordinator()
        do {
            _ = try managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil,  withConfiguration:nil,  options:nil);
        } catch {
            print(error)
        }
        RKLogConfigureFromEnvironment()
        managedObjectStore.createManagedObjectContexts()
        managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)
        
        // Initialize RestKit for server cooperation:
        let manager = RKObjectManager(baseURL: NSURL(string: baseURL))
        manager.requestSerializationMIMEType = RKMIMETypeJSON
        manager.managedObjectStore = managedObjectStore
        
        
        //Channels
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: YTChannel.mappingInStore(managedObjectStore), method: .GET, pathPattern: "subscriptions", keyPath: "items", statusCodes: RKStatusCodeIndexSetForClass(.Successful)))
        
        //Playlists
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: YTPlaylist.mappingInStore(managedObjectStore), method: .GET, pathPattern: "playlists", keyPath: "items", statusCodes: RKStatusCodeIndexSetForClass(.Successful)))
        
        //Videos
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: YTVideo.mappingInStore(managedObjectStore), method: .GET, pathPattern: "playlistItems", keyPath: "items", statusCodes: RKStatusCodeIndexSetForClass(.Successful)))
        
        //Search
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: YTSearchedVideo.mappingInStore(managedObjectStore), method: .GET, pathPattern: "search", keyPath: "items", statusCodes: RKStatusCodeIndexSetForClass(.Successful)))
        
        RKObjectManager.setSharedManager(manager)
    }
    
    class func saveContext() {
        do {
            try RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext.saveToPersistentStore()
        } catch {
            print("Saving context error: \(error)")
        }
    }

}
