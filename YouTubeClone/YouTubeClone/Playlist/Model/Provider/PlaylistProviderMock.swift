//
//  PlaylistProviderMock.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

class PlaylistProviderMock : PlaylistProviderProtocol {
    
    
    func getPlaylist(channelId : String) async throws -> PlayListModel{
        
        guard let model = Utils.parseJson(jsonName: "Playlist", model: PlayListModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
}

