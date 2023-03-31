//
//  HomeProviderMock.swift
//  YouTubeClone
//
//  Created by fabian zarate on 19/03/2023.
//

import Foundation

class HomeProviderMock : HomeProviderProtocol {
    
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        
        guard let model = Utils.parseJson(jsonName: "SearchVideo", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlaylist(channelId: String) async throws -> PlayListModel {
        guard let model = Utils.parseJson(jsonName: "Playlist", model: PlayListModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getChannels(channelId: String) async throws -> ChannelModel {
        guard let model = Utils.parseJson(jsonName: "Channel", model: ChannelModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlaylistItems(playlistId: String) async throws -> PlayListItemModel {
        guard let model = Utils.parseJson(jsonName: "PlaylistItem", model: PlayListItemModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
    
    
}
