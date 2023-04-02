//
//  PlaylistPresenter.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import Foundation

protocol PlaylistViewProtocol : AnyObject {
    func getData(list : [PlayListModel.Item])
}
@MainActor
class PlaylistPresenter{
    
    private var provider : PlaylistProviderProtocol
    weak var delegate : PlaylistViewProtocol?
    private var dataVideos : [PlayListModel.Item] = []
    
    
    init(provider: PlaylistProvider = PlaylistProvider() , delegate: PlaylistViewProtocol) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = PlaylistProviderMock()
        }
        #endif
    }
    
    func getPlaylist() async{
        dataVideos.removeAll()
        
        async let playlist = try await provider.getPlaylist(channelId: Constants.channelId).items

        do {
            let (responsePlaylist) = await (try playlist)

            dataVideos = responsePlaylist
            
        }catch{
            print("error",error)
        }
        
        delegate?.getData(list: dataVideos)
    }
}




