//
//  Photo.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class Photo: NSObject {
    var urlString: String = ""
    var loadingURL: Bool = false
    var loadingURLCompletion: ((String) -> Void)?
    
    func requestURL(completion: @escaping (String) -> Void) {
        self.loadingURL = true
        self.loadingURLCompletion = completion
        PhotoUrlProvider().requestNewPhotoURL { [weak self] _urlString in
            self?.loadingURL = false
            self?.urlString = _urlString
            self?.loadingURLCompletion?(_urlString)
        }
    }
}
