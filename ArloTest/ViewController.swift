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
    
        collectionView.register(UINib(nibName: "SpringBoardCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SpringBoardCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        bindViewModel()
    }
    
    @IBAction func reloadAllButtonTapped(_ sender: Any) {
        viewModel.reloadAll()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        viewModel.addNewPhoto()
    }
}

extension ViewController {
    func bindViewModel() {
        viewModel.didAddNewPhoto = { [weak self] photo in
            
        }
        
        viewModel.didReloadAll = { [weak self] in
            self?.collectionView.reloadData()
        }
        
//        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.onAppWillTerminate(notification:)), name: UIApplication.willTerminateNotification, object:nil)
//        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.onAppWillEnterBackground(notification:)), name: UIApplication.didEnterBackgroundNotification, object:nil)
    }
    
//    @objc func onAppWillTerminate(notification:Notification) {
//        viewModel.catchPhotos()
//    }
//
//    @objc func onAppWillEnterBackground(notification:Notification) {
//        viewModel.catchPhotos()
//    }
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
