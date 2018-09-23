//
//  Monoid.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

protocol Monoid: Semigroup {
    static var empty: Self { get }
}

extension Sequence where Element: Monoid {
    func concat() -> Element {
        return concat(Element.empty)
    }
}

extension Monoid {
    func when(_ predicate: Bool) -> Self {
        return predicate ? self : Self.empty
    }
}
