// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YTChannel.swift instead.

import Foundation
import CoreData

public enum YTChannelAttributes: String {
    case descr = "descr"
    case id = "id"
    case photoUrl = "photoUrl"
    case title = "title"
}

public enum YTChannelRelationships: String {
    case playlist = "playlist"
}

public class _YTChannel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Channel"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _YTChannel.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var descr: String?

    @NSManaged public
    var id: String?

    @NSManaged public
    var photoUrl: String?

    @NSManaged public
    var title: String?

    // MARK: - Relationships

    @NSManaged public
    var playlist: NSSet

}

extension _YTChannel {

    func addPlaylist(objects: NSSet) {
        let mutable = self.playlist.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.playlist = mutable.copy() as! NSSet
    }

    func removePlaylist(objects: NSSet) {
        let mutable = self.playlist.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.playlist = mutable.copy() as! NSSet
    }

    func addPlaylistObject(value: YTPlaylist) {
        let mutable = self.playlist.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.playlist = mutable.copy() as! NSSet
    }

    func removePlaylistObject(value: YTPlaylist) {
        let mutable = self.playlist.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.playlist = mutable.copy() as! NSSet
    }

}

