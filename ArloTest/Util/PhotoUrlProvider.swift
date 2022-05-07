//
//  PhotoUrlProvider.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import Foundation

class PhotoUrlProvider: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    static let basePhotoURLString: String = "https://loremflickr.com/200/200/"
    //static let defaultPhotoURLString: String = "https://loremflickr.com/cache/resized/65535_51834731681_6343af38e1_n_200_200_nofilter.jpg"
    
    public private(set) var photoURLString: String = ""
    private var completion: ((String) -> Void)?
    
    func myHandler(data: Data!, response: URLResponse!, error: Error!) -> Void {

//        // In this case the “encoding” is NSASCIIStringEnconding. It depends on the website.
//        let responseBody = String(data: data, encoding: String.Encoding.ascii)
//
//        print(responseBody ?? "")
    }
    
    func requestNewPhotoURL(completionHandler: @escaping (_ urlString: String) -> Void) {
        self.completion = completionHandler
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: self, delegateQueue: OperationQueue())
        let data = session.dataTask(with: URL(string: PhotoUrlProvider.basePhotoURLString)!, completionHandler: myHandler)
        
        data.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        //https://loremflickr.com/cache/resized/65535_51834731681_6343af38e1_n_200_200_nofilter.jpg
        guard let urlString = request.url?.absoluteString,
           urlString.contains("https://loremflickr.com/cache") else {
               completionHandler(request)
               return
        }
        
        self.photoURLString = urlString
        self.completion?(urlString)
        print(urlString)
        completionHandler(nil)
    }
}
