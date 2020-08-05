//
//  HomeViewController.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/07/31.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    let sections = Bundle.main.decode([Section].self, from: "discover.json")
        var collectionView: UICollectionView!
        
        var dataSource: UICollectionViewDiffableDataSource<Section, Person>?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.backgroundColor = .systemBackground
            view.addSubview(collectionView)
            
            
            collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
            collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
            collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
            collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)
            
            createDataSource()
            reloadData()
        }
        
        func configue<T: SelfConfiguringCell>(_ cellType: T.Type, with person: Person, for indexPath: IndexPath) -> T {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to deque \(cellType)")
            }
            
            cell.configuring(with: person)
            return cell
        }
        
        
        func createDataSource(){
    //        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, app) -> UICollectionViewCell? in
    //            switch self.sections[indexPath.section].type {
    //            default:
    //                return self.configue(FeaturedCell.self, with: app, for: indexPath)
    //            }
    //        })
            
           dataSource = UICollectionViewDiffableDataSource<Section, Person>(collectionView: collectionView ) { (collectionView, indexPath, person) -> UICollectionViewCell? in
                switch self.sections[indexPath.section].type {
                case "mediumTable" :
                    return self.configue(MediumTableCell.self, with: person, for: indexPath)
                case "smallTableCell":
                    return self.configue(SmallTableCell.self, with: person, for: indexPath)
                default:
                    return self.configue(FeaturedCell.self, with: person, for: indexPath)
                }
            }
            dataSource?.supplementaryViewProvider = {[weak self]
                collectionView, kind, indexPath in
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
                    else {
                        return nil
                }
                
                guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else {return nil}
                guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else {
                    return nil
                }
                if section.title.isEmpty {return nil}
                
                sectionHeader.title.text = section.title
                sectionHeader.subtitle.text = section.subtitle
                return sectionHeader
            }
            
        }
        
        func reloadData()  {
            var snapShot = NSDiffableDataSourceSnapshot<Section, Person>()
            snapShot.appendSections(sections)
            
            for section in sections {
                snapShot.appendItems(section.items, toSection: section)
            }
            
            dataSource?.apply(snapShot)
        }
        
        func createCompositionalLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {
                sectionIndex, layoutEnviroment in
                let section = self.sections[sectionIndex]
                
                switch section.type {
                case "mediumTable":
                    return self.createMediumTableCell(using: section)
                case "smallTable":
                    return self.createSmallTableSection(using: section)
                default:
                    return self.createFeaturedSection(using: section)
                }
            }
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20
            layout.configuration = config
            return layout
        }
        
        
        func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
            
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered //Edit
            return layoutSection
        }
        
        func createMediumTableCell(using section: Section) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
            
            let layoutGroup  = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            
           let layoutSectionHeader = createSectionHeader()
            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
            
            return layoutSection
        }
        
        func createSmallTableSection(using section: Section) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            
            let layoutSectionHeader = createSectionHeader()
                layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
            
            return layoutSection
        }
        
        func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
                let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
                let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            return layoutSectionHeader
        }
        

}
