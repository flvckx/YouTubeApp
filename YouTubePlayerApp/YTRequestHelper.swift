//
//  YTRequestHelper.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import RestKit

class YTRequestHelper: NSObject {
    private class func getRequest(path: String, params:[NSObject: AnyObject], success: (()->())?, failure: (()->())?) {
        RKObjectManager.sharedManager().getObject(nil, path: path, parameters: params, success: { (operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) in
            success?()
                 print(operation.HTTPRequestOperation.description)
        }) { (operation: RKObjectRequestOperation!, error: NSError!) in
            if (operation.HTTPRequestOperation.response.statusCode == 403 || operation.HTTPRequestOperation.response.statusCode == 401) {
                if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                    delegate.showLoginScreen()
                }
            } else {
                failure?()
            }
        }
    }
    
    class func getSubscription(success: (()->())?, failure: (()->())?) {
        let token = SCLogin.getToken()!
        let params = ["part" : "snippet,contentDetails",
                      "maxResults" : "50",
                      "mine": "true",
                      "access_token": token]
        getRequest("subscriptions", params: params, success: success, failure: failure)
    }
    
    class func getPlaylists(channelId: String, success: (()->())?, failure: (()->())?) {
        let token = SCLogin.getToken()!
        let params = ["part" : "snippet,contentDetails",
                      "maxResults" : "50",
                      "channelId" : channelId,
                      "access_token" : token]
        getRequest("playlists", params: params, success: success, failure: failure)
    }
    
    class func getVideoItems(playlistId: String, success: (()->())?, failure: (()->())?) {
        let token = SCLogin.getToken()!
        let params = ["part" : "snippet,contentDetails",
                      "maxResults" : "50",
                      "playlistId" : playlistId,
                      "access_token" : token]
        getRequest("playlistItems", params: params, success: success, failure: failure)
    }
    
    class func searchVideos(searchInfo: String, success: (()->())?, failure: (()->())?) {
        let token = SCLogin.getToken()!
        let params = ["part" : "snippet",
                      "maxResults" : "25",
                      "q" : searchInfo,
                      "type" : "video",
                      "order" : "viewCount",
                      "access_token" : token]
        getRequest("search", params: params, success: success, failure: failure)
    }
}
