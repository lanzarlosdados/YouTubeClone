//
//  HomePresenter.swift
//  YouTubeClone
//
//  Created by fabian zarate on 14/03/2023.
//

import Foundation

protocol HomeViewProtocol : AnyObject {
    func getData(list : [[Any]])
}

class HomePresenter{
    
    private var provider : HomeProviderProtocol
    weak var delegate : HomeViewProtocol?
    private var dataVideos : [[Any]] = []
    
    
    init(provider: HomeProviderProtocol = HomeProvider() , delegate: HomeViewProtocol) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func getVideos() async{
        dataVideos.removeAll()
        
        do {
            let channel = try await provider.getChannels(channelId: Constants.channelId).items
            let playlist = try await provider.getPlaylist(channelId: Constants.channelId).items
            let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
            
            let playlistItems = try await provider.getPlaylistItems(playlistId: playlist.first?.id ?? "").items
            
            dataVideos.append(channel)
            dataVideos.append(playlistItems)
            dataVideos.append(videos)
            dataVideos.append(playlist)
            
        }catch{}
        
        delegate?.getData(list: dataVideos)
    }
}
