import Foundation
import RestKit

@objc(YTPlaylist)
public class YTPlaylist: _YTPlaylist {
	class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
        mapping.addAttributeMappingsFromDictionary(["snippet.thumbnails.default.url" : "url",
            "id" : "id",
            "snippet.title" : "title",
            "contentDetails.itemCount" : "itemCount",
            "snippet.channelId" : "subscriptionId"
            ])        
        mapping.identificationAttributes = ["id"]
        return mapping!
    }
}
