//
//  CollectionViewModel.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 3/31/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

class HomeViewModel:ObservableObject {
    @Published var collectionList:[Collection] = []
    @Published var photoList:[Photo] = []
    @Published var randomPhoto:Photo?
    
    var isFirtime:Bool = false
    
    func fetchHomeData() {
        fetchCollectionList()
        fetchPhotoList()
    }
    
    private func fetchCollectionList() {
        CloudRequest.getCollections { (collectionList, error) in
            guard error == nil else { return }
            
            self.collectionList = collectionList ?? []
        }
    }
    
    private func fetchPhotoList() {
        CloudRequest.getNewPhotos { (photoList, error) in
            guard error == nil else { return }
            
            self.photoList = photoList ?? []
        }
    }
    
    func fetchRandomPhoto() {
        CloudRequest.getRandomPhoto { (photo, error) in
            guard error == nil,
                photo != nil else { return }
            
            self.randomPhoto = photo
        }
    }
    
    func startTimerToGetRandomPhoto() {
        if !isFirtime {
            fetchRandomPhoto()
            isFirtime = true
        }
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(getRandomPhoto), userInfo: nil, repeats: true)
    }
    
    @objc func getRandomPhoto() {
        fetchRandomPhoto()
    }

}
