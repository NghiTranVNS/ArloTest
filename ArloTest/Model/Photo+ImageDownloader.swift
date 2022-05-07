//
//  Photo+ImageDownloader.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/7/22.
//

import Kingfisher

extension Photo {
    func downoadImage() {
        guard urlString.count > 0, let url = URL(string: urlString) else { return }
        
        let imgDownloader: ImageDownloader = ImageDownloader(name: "Test image downloader")
        imgDownloader.downloadImage(with: url, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let imageLoadingResult):
                //let img = imageLoadingResult.image
                
                break
            case .failure(_):
                break
            }
        }
    }
}
