import Foundation
import RestKit

@objc(YTChannel)
public class YTChannel: _YTChannel {
    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
        mapping.addAttributeMappingsFromDictionary(["snippet.thumbnails.default.url" : "photoUrl",
            "snippet.resourceId.channelId" : "id",
            "snippet.title" : "title",
            "snippet.description" : "descr"
            ])
        mapping.identificationAttributes = ["id"]
        return mapping!
    }

}
