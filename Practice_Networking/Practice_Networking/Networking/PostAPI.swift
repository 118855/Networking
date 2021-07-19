//
//  PostAPI.swift
//  Practice_Networking
//
//  Created by admin on 19.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import Foundation

class PostAPI {
    static let shared = PostAPI()
    
    private let urlString = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts (onCompletion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            guard let data = data else { return print("data nil") }
            
            
            guard let postsData = try? JSONDecoder().decode([Post].self, from: data) else {
                return print("cant decode")}
            onCompletion(postsData)
            
        }.resume()
    }
}
