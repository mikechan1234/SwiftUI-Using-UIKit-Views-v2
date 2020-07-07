//
//  iTunesRSSFeedApp.swift
//  iTunesRSSFeed
//
//  Created by michael.chan on 07/07/2020.
//  Copyright © 2020 Michael. All rights reserved.
//

import SwiftUI

@main
struct iTunesRSSFeedApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                FeedTypeSelectionView().navigationBarTitle("Feed Type", displayMode: .inline)
                
            }
            
        }
        
    }
    
}
