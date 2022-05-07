//
//  Photo.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class Photo: NSObject, NSCoding {
    var ID: Int = 0
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
    
    //MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(ID, forKey: "ID")
        coder.encode(urlString, forKey: "urlString")
    }

    init(urlString: String) {
        self.urlString = urlString
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.urlString = (coder.decodeObject(forKey: "urlString") as? String) ?? ""
        self.ID = coder.decodeInteger(forKey: "ID")
    }
}
