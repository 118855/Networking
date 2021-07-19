//
//  Posts.swift
//  Practice_Networking
//
//  Created by admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import Foundation

struct  Post: Decodable {
    let userId : Int?
    let id: Int?
    let title: String?
    let body: String?
}
