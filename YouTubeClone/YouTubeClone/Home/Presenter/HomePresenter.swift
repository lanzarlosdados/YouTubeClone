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
    
    init(provider: HomeProviderProtocol = HomeProvider() , delegate: HomeViewProtocol) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func getVideos(){
        delegate?.getData(list: <#T##[[Any]]#>)
    }
}
