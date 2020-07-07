//
//  FeedType.swift
//  iTunesRSSFeed
//
//  Created by michael.chan on 07/07/2020.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

enum FeedType: String, CaseIterable {
    
    case comingSoon = "coming-soon"
    case hotTracks = "hot-tracks"
    case newReleases = "new-releases"
    case topAlbums = "top-albums"
    case topSongs = "top-songs"
    
}

//MARK: - CustomStringCovertible
extension FeedType: CustomStringConvertible {
    
    var description: String {
        
        switch self {
        case .comingSoon:
            return "Coming Soon"
        case .hotTracks:
            return "Hot Tracks"
        case .newReleases:
            return "New Releases"
        case .topAlbums:
            return "Top Albums"
        case .topSongs:
            return "Top Songs"
        }
        
    }
    
}

extension FeedType {
    
    func listConfiguration() -> UIListContentConfiguration {
        
        var configuration = UIListContentConfiguration.cell()
        configuration.text = description
        
        return configuration
        
    }
    
}
