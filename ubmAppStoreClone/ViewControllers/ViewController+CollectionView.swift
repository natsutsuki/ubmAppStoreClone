//
//  ViewController+CollectionView.swift
//  AppStore
//
//  Created by c.c on 2019/6/11.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 420)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cardViewModel = cardViewData[indexPath.item]
        switch cardViewModel.viewType
        {
        case let .appArticle(val):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppArticleCell", for: indexPath) as! AppArticleCell
            
            cell.appArticleView.config(bgImage: val.bgImage, bgType: val.bgType, title: val.title, subtitle: val.subtitle, description: val.description)
            
            return cell
            
        case let .appCollection(val):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCollectionCell", for: indexPath) as! AppCollectionCell
            
            cell.appCollectionView.config(apps: val.apps, title: val.title, subtitle: val.subtitle)
            
            return cell
            
        case let .appOfTheDay(val):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppOfTheDayCell", for: indexPath) as! AppOfTheDayCell
            
            cell.appOfTheDayView.config(bgImage: val.bgImage, bgType: val.bgType, app: val.app)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cardViewModel = cardViewData[indexPath.item]
        let tgvc = ArticleViewController.init(cardViewModel.viewType)
        
        tgvc.transitioningDelegate = self
        tgvc.modalPresentationStyle = .custom

        present(tgvc, animated: true, completion: nil)
    }
    
}
