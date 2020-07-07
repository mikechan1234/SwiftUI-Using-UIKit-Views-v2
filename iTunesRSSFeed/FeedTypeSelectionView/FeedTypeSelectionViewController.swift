//
//  FeedTypeSelectionViewController.swift
//  iTunesRSSFeed
//
//  Created by michael.chan on 07/07/2020.
//  Copyright © 2020 Michael. All rights reserved.
//

import SwiftUI

enum FeedTypeSelectionCollectionSection {
    case main
}

class FeedTypeSelectionViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<FeedTypeSelectionCollectionSection, FeedType>!
    let feedTypes: [FeedType] = FeedType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .plain))
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        
        let cell = UICollectionView.CellRegistration<UICollectionViewListCell, FeedType> { (listCell, indexPath, feedType) in
            
            listCell.contentConfiguration = feedType.listConfiguration()
            listCell.accessories = [.disclosureIndicator()]
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<FeedTypeSelectionCollectionSection, FeedType>(collectionView: collectionView) { (collectionView, indexPath, feedType) -> UICollectionViewCell? in

            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: feedType)
            
        }
        
        applySnapshot(feedType: feedTypes, animated: true)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])

    }
    
    func applySnapshot(feedType: [FeedType], animated: Bool) {
        
        var currentSnapshot = NSDiffableDataSourceSnapshot<FeedTypeSelectionCollectionSection, FeedType>()
        
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(feedTypes, toSection: .main)

        dataSource.apply(currentSnapshot, animatingDifferences: animated)
        
    }
    
}

//MARK: - UICollectionViewDelegate
extension FeedTypeSelectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let feedView = FeedView(viewModel: FeedViewModel(feedType: feedTypes[indexPath.row]))
        let hostingViewController = UIHostingController(rootView: feedView)
        
        navigationController?.pushViewController(hostingViewController, animated: true)
        
    }
    
}
