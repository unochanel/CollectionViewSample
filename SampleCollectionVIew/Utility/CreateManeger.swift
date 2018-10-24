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
    var tappedDate: Date
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
            creates[index].tappedDate = Date()
            return
        }
        creates[index].tapped = false
    }

    func all() -> [TagList] {
        creates.sort(by: { $0.tappedDate < $1.tappedDate })
        return creates
    }
}
