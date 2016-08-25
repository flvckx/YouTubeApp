import Foundation
import RestKit

@objc(YTVideo)
public class YTVideo: _YTVideo {
    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
        mapping.addAttributeMappingsFromDictionary(["snippet.thumbnails.default.url" : "url",
            "snippet.resourceId.videoId" : "id",
            "snippet.title" : "title",
            "snippet.playlistId" : "playlistId"
            ])
        mapping.identificationAttributes = ["id"]
        return mapping!
    }
}
