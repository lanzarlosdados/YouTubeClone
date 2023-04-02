//
//  PlaylistProvider.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import Foundation

protocol PlaylistProviderProtocol : AnyObject {
    func getPlaylist(channelId : String) async throws -> PlayListModel
}


class PlaylistProvider : PlaylistProviderProtocol {
    
    
    func getPlaylist(channelId : String) async throws -> PlayListModel{
        
        var queryParameters : [String : String ] = ["part":"snippet,contentDetails","channelId":channelId]

        let request = RequestModel(endpoint: .playlist , queryItems: queryParameters)
        
        do{
            let model = try await  ServiceLayer.callService(request, PlayListModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
}
