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

    func tapped(index: Int) {
        guard creates[index].tapped else {
            creates[index].tapped = true
            return
        }
        creates[index].tapped = false
    }

    func all() -> [TagList] {
        return creates
    }
}
