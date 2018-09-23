//
//  Extensions.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

extension Array: Monoid {
    static var empty: Array<Element> { return [] }
    func append(_ other: Array<Element>) -> Array<Element> {
        return self + other
    }
}
