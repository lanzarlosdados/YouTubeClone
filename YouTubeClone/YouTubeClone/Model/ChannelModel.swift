//
//  ChannelModel.swift
//  YouTubeClone
//
//  Created by fabian zarate on 07/03/2023.
//


import Foundation

struct ChannelModel: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [Item]
    
    struct Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let statistics: Statistics
        let brandingSettings: BrandingSettings
        
        struct Snippet: Codable {
            let title, description, customURL, publishedAt: String
            let thumbnails: Thumbnails
            let localized: Localized
            let country: String

            enum CodingKeys: String, CodingKey {
                case title, description
                case customURL = "customUrl"
                case publishedAt, thumbnails, localized, country
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
            
            struct Localized: Codable {
                let title, description: String
            }
            
        }
        
        struct BrandingSettings: Codable {
            let channel: Channel
            let image: Image
            
            struct Channel: Codable {
                let title, description, keywords, defaultLanguage: String?
                let country: String
            }
            
            struct Image: Codable {
                let bannerExternalURL: String?

                enum CodingKeys: String, CodingKey {
                    case bannerExternalURL = "bannerExternalUrl"
                }
            }
            
        }
        
        struct Statistics: Codable {
            let viewCount, subscriberCount: String
            let hiddenSubscriberCount: Bool
            let videoCount: String
        }
        
    }
    
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
}
