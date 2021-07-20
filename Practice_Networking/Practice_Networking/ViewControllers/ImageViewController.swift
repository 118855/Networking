//
//  ImageViewController.swift
//  Practice_Networking
//
//  Created by admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
    }
    private func downloadImage() {
        
        guard let url = URL(string: Hosts.getImage) else {return}

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.session.dataTask(with: url) {(data, responce, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }.resume()
    }

}
