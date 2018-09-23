//
//  Semigroup.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

protocol Semigroup {
    func append(_ other: Self) -> Self
}

extension Sequence where Element: Semigroup {
    func concat(_ initialValue: Element) -> Element {
        return reduce(initialValue) { $0.append($1) }
    }
}

extension Semigroup {
    static func <> (lhs: Self, rhs: Self) -> Self {
        return lhs.append(rhs)
    }
}
