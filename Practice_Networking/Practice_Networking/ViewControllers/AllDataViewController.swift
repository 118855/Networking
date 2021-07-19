//
//  AllDataViewController.swift
//  Practice_Networking
//
//  Created by admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit

class AllDataViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var postsList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
      
        tableView.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        
        let functionForFetching = { (fetchedPostData: [Post]) in
            DispatchQueue.main.async {
                self.postsList = fetchedPostData
                self.tableView.reloadData()
            }
        }
        PostAPI.shared.fetchPosts(onCompletion: functionForFetching)
    }
}

extension AllDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else {return UITableViewCell()}
        let post = postsList[indexPath.row]
        cell.setCell(post: post)
        return cell
    }
}

