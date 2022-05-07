//
//  Photo.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class Photo: NSObject, NSCoding {
    var urlString: String = ""
    
    var section: Int = 0
    var row: Int = 0
    var isLoadingURL: Bool = false
    var loadingURLCompletion: ((String, Int, Int) -> Void)?
    
    func requestURL() {
        self.isLoadingURL = true
        PhotoUrlProvider().requestNewPhotoURL { [weak self] _urlString in
            guard let strongSelf = self else { return }
            strongSelf.isLoadingURL = false
            strongSelf.urlString = _urlString
            strongSelf.loadingURLCompletion?(_urlString, strongSelf.section, strongSelf.row)
        }
    }
    
    func requestURL(completion: @escaping (String, Int, Int) -> Void) {
        self.isLoadingURL = true
        PhotoUrlProvider().requestNewPhotoURL { [weak self] _urlString in
            guard let strongSelf = self else { return }
            strongSelf.isLoadingURL = false
            strongSelf.urlString = _urlString
            completion(_urlString, strongSelf.section, strongSelf.row)
        }
    }
    
    //MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(urlString, forKey: "urlString")
    }

    init(urlString: String, section: Int, row: Int) {
        self.urlString = urlString
        self.section = section
        self.row = row
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.urlString = (coder.decodeObject(forKey: "urlString") as? String) ?? ""
    }
}
