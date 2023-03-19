//
//  PlayListItemModel.swift
//  YouTubeClone
//
//  Created by fabian zarate on 07/03/2023.
//

import Foundation

// MARK: - PlayListItemModel
struct PlayListItemModel: Codable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        struct ContentDetails: Codable {
            let videoID: String
            let videoPublishedAt: String

            enum CodingKeys: String, CodingKey {
                case videoID = "videoId"
                case videoPublishedAt
            }
        }
        
        struct Snippet: Codable {
            let publishedAt: String
            let channelID, title, description: String
            let thumbnails: Thumbnails
            let channelTitle, playlistID: String
            let position: Int
            let resourceID: ResourceID
            let videoOwnerChannelTitle, videoOwnerChannelID: String

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title, description, thumbnails, channelTitle
                case playlistID = "playlistId"
                case position
                case resourceID = "resourceId"
                case videoOwnerChannelTitle
                case videoOwnerChannelID = "videoOwnerChannelId"
            }
            
            struct ResourceID: Codable {
                let kind, videoID: String

                enum CodingKeys: String, CodingKey {
                    case kind
                    case videoID = "videoId"
                }
            }

            struct Thumbnails: Codable {
                let thumbnailsDefault, medium, high, standard: Default
                let maxres: Default

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high, standard, maxres
                }
                
                struct Default: Codable {
                    let url: String
                    let width, height: Int
                }
            }
        }
    }
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
}


