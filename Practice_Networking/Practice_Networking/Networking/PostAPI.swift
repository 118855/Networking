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

    func fetchPosts (onCompletion: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: Hosts.getData) else {return}

        NetworkManager.session.dataTask(with: url) { (data, responce, error) in
            
            guard let response = responce,
                  let data = data else { return print("data nil") }
            print(response)
            do {
             let postsData = try JSONDecoder().decode([Post].self, from: data)
                onCompletion(postsData )
            } catch {
                print(error)
            }
        }.resume()
    }
}
