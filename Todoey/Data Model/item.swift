//
//  item.swift
//  Todoey
//
//  Created by Administrator on 5/23/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
