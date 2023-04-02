//
//  VideoPresenter.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import Foundation

protocol VideoViewProtocol : AnyObject {
    func getData(list : [Any])
}
@MainActor
class VideoPresenter{
    
    private var provider : VideoProviderProtocol
    weak var delegate : VideoViewProtocol?
    private var dataVideos : [Any] = []
    
    
    init(provider: VideoProviderProtocol = VideoProvider() , delegate: VideoViewProtocol) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = VideoProviderMock()
        }
        #endif
    }
    
    func getVideos() async{
        dataVideos.removeAll()
        
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        
        do {
            let (responseVideos) = await (try videos)

            dataVideos = responseVideos
            
        }catch{
            print("error",error)
        }
        
        delegate?.getData(list: dataVideos)
    }
}


