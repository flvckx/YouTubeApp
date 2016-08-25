import Foundation
import RestKit

@objc(YTSearchedVideo)
public class YTSearchedVideo: _YTSearchedVideo {
    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
        mapping.addAttributeMappingsFromDictionary(["snippet.thumbnails.default.url" : "url",
            "id.videoId" : "id",
            "snippet.title" : "title",
            "kind" : "kind",
            "etag" : "etag"
            ])
        mapping.identificationAttributes = ["id"]
        return mapping!
    }
}
