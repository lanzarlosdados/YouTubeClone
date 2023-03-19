//
//  VideoModel.swift
//  YouTubeClone
//
//  Created by fabian zarate on 07/03/2023.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Decodable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
    
    struct Item: Codable {
        let kind, etag: String
        let id : VideoID
        let snippet: Snippet
        
        struct VideoID : Codable {
            let kind,channelId,playlistId : String?
        }
        
        struct Snippet: Codable {
            let publishedAt: String
            let channelID, title, description: String
            let thumbnails: Thumbnails
            let channelTitle: String
            let liveBroadcastContent: String

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title, description, thumbnails, channelTitle
                case liveBroadcastContent
            }

            struct Thumbnails: Codable {
                let thumbnailsDefault, medium, high: Default

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high
                }
                
                struct Default: Codable {
                    let url: String
                    let width, height: Int
                }
            }
            
        }
        
    }

}

