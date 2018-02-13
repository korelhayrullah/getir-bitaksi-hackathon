//
//  DataClass.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import Foundation

class Data{
    let id: String
    let key: String
    let value: String
    let createdAt: String
    let totalCount: Int
    
    init(id: String, key: String, value: String, createdAt: String, totalCount: Int) {
        self.id = id
        self.key = key
        self.value = value
        self.createdAt = createdAt
        self.totalCount = totalCount
    }
}
