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
        reloadAllButton.setTitle(viewModel.reloadTitle, for: .normal)
        
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
            guard let indexPath = self?.viewModel.lastIndexPath() else { return }
            guard let strongSelf = self else { return }
            
            strongSelf.collectionView.performBatchUpdates({
                if indexPath.row == 0 {
                    strongSelf.collectionView.insertSections(IndexSet(integer: indexPath.section))
                }
                else {
                    strongSelf.collectionView.reloadSections(IndexSet(integer: indexPath.section))
                }
            }, completion: { _ in
                guard let currentIndex = strongSelf.collectionView.indexPathsForVisibleItems.first else { return }
                if currentIndex.section < strongSelf.viewModel.photoSections.count - 1 {
                    let rightX = CGFloat(strongSelf.viewModel.photoSections.count - 1) * strongSelf.viewModel.pageSize.width
                    strongSelf.collectionView.setContentOffset(CGPoint(x: rightX, y: 0), animated: true)
                }
            })
        }
        
        viewModel.didReloadAll = { [weak self] in
            self?.collectionView.reloadData()
        }
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
