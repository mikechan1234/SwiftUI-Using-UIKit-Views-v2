//
//  FeedView.swift
//  iTunesRSSFeed
//
//  Created by Michael on 26/9/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import SwiftUI

struct FeedView: View {
	
	@ObservedObject var viewModel: FeedViewModel
	
    var body: some View {
		
        FeedCollectionView(items: $viewModel.items).navigationBarTitle(viewModel.feedType.description).onAppear {
			
			self.viewModel.getFeed()
			
		}
		
    }
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			FeedView(viewModel: FeedViewModel())
		}
    }
}
