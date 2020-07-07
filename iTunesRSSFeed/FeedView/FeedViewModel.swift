//
//  ContentViewModel.swift
//  iTunesRSSFeed
//
//  Created by Michael on 26/9/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
	
	let urlSession = URLSession(configuration: .default)
	@Published var items: [FeedItem] = []
    var cancellable: AnyCancellable?
    var feedType: FeedType = .topSongs
    
    init(feedType: FeedType = .topSongs) {
        
        self.feedType = feedType
        
    }
	
}

extension FeedViewModel {
	
	func getFeed() {
		
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/gb/apple-music/\(feedType.rawValue)/all/10/explicit.json") else {
			return
		}
		
		cancellable = urlSession.dataTaskPublisher(for: url).map { (data, response) -> Data in
			
			data
			
		}.tryMap { (data) -> iTunesRSS in

			let jsonDecoder = JSONDecoder()
			jsonDecoder.dateDecodingStrategy = .custom(JSONDecoder.DateDecodingStrategy.feed)
			
			return try jsonDecoder.decode(iTunesRSS.self, from: data)

		}.map { (rss) -> [FeedItem] in
			
			rss.feed.results
			
		}.receive(on: DispatchQueue.main).sink(receiveCompletion: { (completion) in
			
			switch completion {
				
			case .failure(let error):
                print(error)
				break
			
			case .finished:
                
				break
				
			}
			
		}) {[unowned self] (items) in
			
			self.items.append(contentsOf: items)
			
        }
		
	}
	
}
