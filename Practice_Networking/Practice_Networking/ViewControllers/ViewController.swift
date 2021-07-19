//
//  ViewController.swift
//  Practice_Networking
//
//  Created by anna on 8/15/19.
//  Copyright © 2019 NIX Solitions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!

    @IBAction func didTapGetButton(_ sender: UIButton) {
        callGetRequest()
    }

    @IBAction func downloadImageTouchUpInside(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            guard let viewController = storyboard.instantiateViewController(identifier: "ImageViewController") as? ImageViewController else {return}
            navigationController?.pushViewController(viewController, animated: true)
        } else { return }
    }
    
    private func callGetRequest() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            guard let responce = responce,
                  let data = data else {return}
            
            print(responce)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
