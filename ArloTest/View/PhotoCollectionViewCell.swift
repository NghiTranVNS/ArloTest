//
//  PhotoCollectionViewCell.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.backgroundColor = UIColor.lightGray
        self.imageView.layer.cornerRadius = 7.0
        self.imageView.clipsToBounds = true
    }
    
    private func downloadImage(url: String) {
        if let url = URL(string: url) {
            indicatorView.startAnimating()
            imageView.kf.setImage(with: url, placeholder: nil, options: nil) { [weak self] result in
                self?.indicatorView.stopAnimating()
            }
        }
    }

    func displayPhoto(_ photo: Photo) {
        imageView.image = nil
        indicatorView.stopAnimating()
        
        if photo.urlString.count > 0 {
            self.downloadImage(url: photo.urlString)
        }
        else if !photo.isLoadingURL {
            indicatorView.startAnimating()
            photo.requestURL()
        }
        else {
            indicatorView.startAnimating()
        }
    }
}
