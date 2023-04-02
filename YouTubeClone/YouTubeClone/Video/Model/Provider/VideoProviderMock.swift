//
//  VideoProviderMock.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import Foundation

class VideoProviderMock : VideoProviderProtocol {
    
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel{
        
        guard let model = Utils.parseJson(jsonName: "SearchVideo", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
