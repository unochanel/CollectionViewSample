//
//  TagResponse.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/18.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation

struct TagResponse: Decodable {
    let tag: [Tag]
    
    enum  CodingKeys: String, CodingKey {
        case tag
    }
    
    struct Tag: Decodable {
        let type: String
        let tag: String
        let date: Date?
        
        enum CodingKeys: String, CodingKey {
            case type
            case tag
            case date
        }
    }
}
