//
//  SpringBoardCollectionViewCell.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/7/22.
//

import UIKit

class SpringBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    public private(set) var photos: [Photo] = []
    public private(set) var viewModel: PhotoViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func displayPhotosInSection(_ section: Int, withViewModel viewModel: PhotoViewModel) {
        guard section < viewModel.photoSections.count else { return }
        
        let photos = viewModel.photoSections[section]
        self.photos = photos
        self.viewModel = viewModel
        
        for photo in self.photos {
            photo.loadingURLCompletion = { [weak self] (_, section, row) in
                DispatchQueue.main.async {
                    self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
                }
            }
        }
        
        collectionView.reloadData()
    }
    
    func appendNewPhoto(_ photo: Photo, atIndex indexPath: IndexPath) {
        self.photos.append(photo)
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [indexPath])
        }, completion: { _ in
            
        })
    }
}

extension SpringBoardCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.displayPhoto(photo)
        
        return cell
    }
}

extension SpringBoardCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: 0, left: viewModel.pageMargin, bottom: 0, right: viewModel.pageMargin)
    }
}

extension SpringBoardCollectionViewCell: UICollectionViewDelegate {
    
}


