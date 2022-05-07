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

    func displayPhoto(_ photo: Photo) {
        imageView.image = nil
        indicatorView.stopAnimating()
        
        if photo.urlString.count > 0{
            if let url = URL(string: photo.urlString) {
                indicatorView.startAnimating()
                imageView.kf.setImage(with: url, placeholder: nil, options: nil) { [weak self] result in
                    self?.indicatorView.stopAnimating()
                }
            }
        }
        else {
            indicatorView.startAnimating()
            photo.requestURL { [weak self] urlString in
                DispatchQueue.main.async {
                    if let url = URL(string: photo.urlString) {
                        self?.imageView.kf.setImage(with: url, placeholder: nil, options: nil) { [weak self] result in
                            self?.indicatorView.stopAnimating()
                        }
                    }
                    else {
                        self?.indicatorView.stopAnimating()
                    }
                }
            }
        }
    }
}
