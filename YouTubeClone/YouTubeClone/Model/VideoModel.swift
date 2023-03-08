//
//  VideoModel.swift
//  YouTubeClone
//
//  Created by fabian zarate on 07/03/2023.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Codable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
    
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        let status: Status
        let statistics: Statistics
        let player: Player
        let topicDetails: TopicDetails
        
        struct Statistics: Codable {
            let viewCount, likeCount, favoriteCount, commentCount: String
        }

        struct Status: Codable {
            let uploadStatus, privacyStatus, license: String
            let embeddable, publicStatsViewable, madeForKids: Bool
        }

        struct TopicDetails: Codable {
            let topicCategories: [String]
        }
        
        struct ContentDetails: Codable {
            let duration, dimension, definition, caption: String
            let licensedContent: Bool
            let projection: String
        }
        
        struct Player: Codable {
            let embedHTML: String

            enum CodingKeys: String, CodingKey {
                case embedHTML = "embedHtml"
            }
        }
        
        struct Snippet: Codable {
            let publishedAt: Date
            let channelID, title, description: String
            let thumbnails: Thumbnails
            let channelTitle: String
            let tags: [String]
            let categoryID, liveBroadcastContent: String
            let localized: Localized
            let defaultAudioLanguage: String

            enum CodingKeys: String, CodingKey {
                case publishedAt
                case channelID = "channelId"
                case title, description, thumbnails, channelTitle, tags
                case categoryID = "categoryId"
                case liveBroadcastContent, localized, defaultAudioLanguage
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

}

