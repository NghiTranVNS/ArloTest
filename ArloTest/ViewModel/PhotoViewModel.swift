//
//  PhotoViewModel.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit
import SwiftUI

class PhotoViewModel: NSObject {
    let width = 7
    let height = 10
    let numberOfItemsPerPage: Int = 70
    let pageMargin: CGFloat = 0 // 32 <-- Update this to change the distance between 2 sections
    let reloadTitle = "Reload All"
    
    var didAddNewPhoto: ((Photo) -> Void)?
    var didReloadAll: (() -> Void)?
    
    public private(set) var photoSections: [[Photo]] = []
    public private(set) var cellSize: CGSize = CGSize.zero
    public private(set) var pageSize: CGSize = CGSize.zero
    
    override init() {
        super.init()
        
        self.calculateCellSize()
        self.calculatePageSize()
        self.initializePhoto()
    }
    
    func initializePhoto() {
        photoSections.removeAll()
        for section in 0...1 {
            var photos: [Photo] = []
            for row in 0...(numberOfItemsPerPage - 1) {
                photos.append(Photo(urlString: "", section: section, row: row))
            }
            photoSections.append(photos)
        }
    }

    
    private func calculateCellSize() {
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width - pageMargin * 2
        
        let cellWidth = screenWidth / CGFloat(width) - 2
        let cellHeight = cellWidth
        
        self.cellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func calculatePageSize() {
        let screenSize: CGRect = UIScreen.main.bounds
        let pageWidth = screenSize.width
        let pageHeight = (pageWidth - pageMargin * 2) * CGFloat(height) / CGFloat(width)
        
        self.pageSize = CGSize(width: pageWidth, height: pageHeight)
    }
    
    func addNewPhoto() {
        let photo = Photo()
        if var lastSection = photoSections.last {
            let sectionIndex = photoSections.count - 1
            if lastSection.count < self.numberOfItemsPerPage {
                let rowIndex = lastSection.count
                photo.section = sectionIndex
                photo.row = rowIndex
                lastSection.append(photo)
                
                photoSections[sectionIndex] = lastSection
            }
            else {
                photo.section = sectionIndex + 1
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
    
    //MARK: - Utils
    func lastIndexPath() -> IndexPath? {
        let section = photoSections.count - 1
        guard section >= 0 else {
            return nil
        }
        
        let row = photoSections[section].count - 1
        guard row >= 0 else {
            return nil
        }
        
        return IndexPath(row: row, section: section)
    }
}
