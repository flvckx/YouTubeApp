// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YTSearchedVideo.swift instead.

import Foundation
import CoreData

public enum YTSearchedVideoAttributes: String {
    case etag = "etag"
    case id = "id"
    case kind = "kind"
    case title = "title"
    case url = "url"
}

public class _YTSearchedVideo: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "SearchedVideo"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _YTSearchedVideo.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var etag: String?

    @NSManaged public
    var id: String?

    @NSManaged public
    var kind: String?

    @NSManaged public
    var title: String?

    @NSManaged public
    var url: String?

    // MARK: - Relationships

}

