//
//  ViewController.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reloadAllButton: UIButton!
    
    let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PhotoUrlProvider().requestNewPhotoURL { urlString in
//            print(urlString)
//        }
//
//        PhotoUrlProvider().requestNewPhotoURL { urlString in
//            print(urlString)
//        }
//
//        PhotoUrlProvider().requestNewPhotoURL { urlString in
//            print(urlString)
//        }
        
        collectionView.register(UINib(nibName: "SpringBoardCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SpringBoardCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func reloadAllButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.photoSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpringBoardCollectionViewCell", for: indexPath) as! SpringBoardCollectionViewCell
        
        cell.displayPhotosInSection(indexPath.section, withViewModel: viewModel)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.pageSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
