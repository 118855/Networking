//
//  NetworkManager.swift
//  Practice_Networking
//
//  Created by admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static var session = URLSession.shared
    
}

struct Hosts {
    
    static var getImage = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    static var postImage = "https://api.imgur.com/3/image"
    static var getData = "https://jsonplaceholder.typicode.com/posts"
}
