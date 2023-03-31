//
//  HomePresenter.swift
//  YouTubeClone
//
//  Created by fabian zarate on 14/03/2023.
//

import Foundation

protocol HomeViewProtocol : AnyObject {
    func getData(list : [[Any]],sectionTitleList : [String])
}
@MainActor
class HomePresenter{
    
    private var provider : HomeProviderProtocol
    weak var delegate : HomeViewProtocol?
    private var dataVideos : [[Any]] = []
    private var sectionTitleList : [String] = []
    
    
    init(provider: HomeProviderProtocol = HomeProvider() , delegate: HomeViewProtocol) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = HomeProviderMock()
        }
        #endif
    }
    
    func getVideosHome() async{
        dataVideos.removeAll()
        sectionTitleList.removeAll()
        
        async let channel = try await provider.getChannels(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylist(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        
        do {
            let (responseChannel, responsePlaylist, responseVideos) = await (try channel, try playlist,try videos)
            
            dataVideos.append(responseChannel)
            sectionTitleList.append("")

            if let id = responsePlaylist.first?.id, let playlistItems = await getPlayListItem(playlistID: id){
                dataVideos.append(playlistItems.items)
                sectionTitleList.append(responsePlaylist.first?.snippet.title ?? "")
            }
            
           
            dataVideos.append(responseVideos)
            sectionTitleList.append("Uplooads")
            
            dataVideos.append(responsePlaylist)
            sectionTitleList.append("Created Playlist")

            
        }catch{
            print("error",error)
        }
        
        delegate?.getData(list: dataVideos,sectionTitleList: sectionTitleList)
    }
    
    func getPlayListItem(playlistID : String) async -> PlayListItemModel?{
        do {
            let playlistItems = try await provider.getPlaylistItems(playlistId: playlistID)
            return playlistItems
        }catch{
            print("error",error)
            return nil
        }
    }
}
