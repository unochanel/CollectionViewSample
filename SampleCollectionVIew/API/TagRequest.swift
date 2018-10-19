//
//  TagResponse.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/18.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation

final class TagRequest {
    func getTag(handler: @escaping (TagResponse) -> Void) {
        let data = try! Data(contentsOf: R.file.tagJson()!)
        let list = try! JSONDecoder().decode(TagResponse.self, from: data)
        handler(list)
    }
}
