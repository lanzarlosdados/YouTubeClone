//
//  PlayListModel.swift
//  YouTubeClone
//
//  Created by fabian zarate on 07/03/2023.
//

import Foundation

// MARK: - PlayListModel
struct PlayListModel: Codable {
    let kind, etag, nextPageToken: String
    let pageInfo: PageInfo
    let items: [Item]
    
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        struct ContentDetails: Codable {
            let itemCount: Int
        }

        struct Snippet: Codable {
            let publishedAt: String
            let channelID, title, description: String
            let thumbnails: Thumbnails
            let channelTitle: String
            let localized: Localized

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title, description, thumbnails, channelTitle, localized
            }
            
            struct Localized: Codable {
                let title, description: String
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
