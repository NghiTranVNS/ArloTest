//
//  ViewController.swift
//  ArloTest
//
//  Created by Nghi Tran on 5/6/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoUrlProvider().requestNewPhotoURL { urlString in
            print(urlString)
        }
    }


}

