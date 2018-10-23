//
//  CreateManeger.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/22.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation

final class CreateManeger {
    private init() {}

    static let shared = CreateManeger()

    var creates: [TagList] = []

    func append(_ create: TagList) {
        creates.append(create)
    }

    func all() -> [TagList] {
        return creates
    }
}
