//
//  Provider.swift
//  YouTubeClone
//
//  Created by fabian zarate on 10/03/2023.
//

import Foundation

protocol HomeProviderProtocol : AnyObject {
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel
    func getPlaylist(channelId : String) async throws -> PlayListModel
    func getChannels(channelId : String) async throws -> ChannelModel
    func getPlaylistItems(playlistId : String) async throws -> PlayListItemModel
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
    
    func getChannels(channelId : String) async throws -> ChannelModel{
        
        let queryParameters : [String : String ] = ["part":"snippet,statistics,brandingSettings","id":channelId]
        
        let request = RequestModel(endpoint: .channels , queryItems: queryParameters)
        
        do{
            let model = try await  ServiceLayer.callService(request, ChannelModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylistItems(playlistId : String) async throws -> PlayListItemModel{
        
        var queryParameters : [String : String ] = ["part":"snippet,id,contentDetails","playlistId": playlistId]
        
        let request = RequestModel(endpoint: .playlistItems , queryItems: queryParameters)
        
        do{
            let model = try await  ServiceLayer.callService(request, PlayListItemModel.self)
            return model
        }catch {
            print(error)
            throw error
        }
    }
    
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
