//
//  PhotoViewModel.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class PhotoViewModel: NSObject {
    let width = 7
    let height = 10
    let numberOfItemsPerPage: Int = 70
    let reloadTitle = "Reload All"
    let storedPhotoKey = "storedPhotoKey"
    
    var didAddNewPhoto: ((Photo) -> Void)?
    var didReloadAll: (() -> Void)?
    
    public private(set) var photoSections: [[Photo]] = []
    public private(set) var cellSize: CGSize = CGSize.zero
    public private(set) var pageSize: CGSize = CGSize.zero
    
    override init() {
        super.init()
        
        self.calculateCellSize()
        self.calculatePageSize()
        
//        if !initializeWithStoredPhotos() {
//            self.initializePhoto()
//        }
        
        self.initializePhoto()
    }
    
    func initializeWithStoredPhotos() -> Bool {
        guard let photoSectionStrings = UserDefaults.standard.array(forKey: storedPhotoKey) as? [[String]] else { return false }
        
        self.photoSections = photoSectionStrings.compactMap({$0.compactMap { urlString in
            return Photo(urlString: urlString)
        }})
        return true
    }
    
    func initializePhoto() {
        photoSections.removeAll()
        for _ in 0...1 {
            var photos: [Photo] = []
            for _ in 0...(numberOfItemsPerPage - 1) {
                photos.append(Photo())
            }
            photoSections.append(photos)
        }
        
        catchPhotos()
    }
    
    func catchPhotos() {
//        UserDefaults.standard.setValue(photoSections.compactMap({ $0.compactMap { photo in
//            photo.urlString
//        } }), forKey: storedPhotoKey)
//        UserDefaults.standard.synchronize()
    }
    
    private func calculateCellSize() {
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let cellWidth = screenWidth / CGFloat(width) - 2
        let cellHeight = cellWidth
        
        self.cellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func calculatePageSize() {
        let screenSize: CGRect = UIScreen.main.bounds
        let pageWidth = screenSize.width
        let pageHeight = pageWidth * CGFloat(height) / CGFloat(width)
        
        self.pageSize = CGSize(width: pageWidth, height: pageHeight)
    }
    
    func addNewPhoto() {
        let photo = Photo()
        if var lastSection = photoSections.last {
            if lastSection.count < self.numberOfItemsPerPage {
                lastSection.append(photo)
            }
            else {
                photoSections.append([photo])
            }
        }
        else {
            photoSections.append([photo])
        }
        
        didAddNewPhoto?(photo)
    }
    
    func reloadAll() {
        initializePhoto()
        didReloadAll?()
    }
}
