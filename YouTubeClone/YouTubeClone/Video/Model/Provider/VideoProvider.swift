//
//  VideoProvider.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import Foundation

protocol VideoProviderProtocol : AnyObject {
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel
}


class VideoProvider : VideoProviderProtocol {
    
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel{
        
        var queryParameters : [String : String ] = ["part":"snippet", "type": "video"]
        if !channelId.isEmpty {
            queryParameters["channelId"] = channelId
        }
        
        if !searchString.isEmpty {
            queryParameters["q"] = searchString
        }
        
        let request = RequestModel(endpoint: .search, queryItems: queryParameters)
        
        do{
            let model = try await  ServiceLayer.callService(request, VideoModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
}
