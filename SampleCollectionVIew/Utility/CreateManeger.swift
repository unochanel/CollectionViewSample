//
//  CreateManeger.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/22.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation

struct TagList {
    let type: String
    let tag: String
    var tapped: Bool
}

final class CreateManeger {
    private init() {}

    static let shared = CreateManeger()

    var creates: [TagList] = []

    func append(_ create: TagList) {
        creates.append(create)
    }

    func createTag(tagList: TagList) {
        creates.insert(tagList, at: 1)
    }

    func tapped(index: Int) {
        if creates[index].tapped == true {
            creates[index].tapped = false
        } else {
            creates[index].tapped = true
        }
    }

    func all() -> [TagList] {
        return creates
    }
}
