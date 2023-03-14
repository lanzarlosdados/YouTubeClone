//
//  Provider.swift
//  YouTubeClone
//
//  Created by fabian zarate on 10/03/2023.
//

import Foundation

protocol HomeProviderProtocol : AnyObject {
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel
}


class HomeProvider : HomeProviderProtocol {
    
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel{
        
        var queryParameters : [String : String ] = ["part":"snippet"]
        
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
