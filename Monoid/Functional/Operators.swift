//
//  Operators.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

precedencegroup BindGroup {
    associativity: left
    higherThan: AdditionPrecedence
}

precedencegroup MapApplyGroup {
    associativity: left
    higherThan: BindGroup
}

precedencegroup AppendGroup {
    associativity: left
    higherThan: MapApplyGroup
}

infix operator >>- : BindGroup
infix operator <^> : MapApplyGroup
infix operator <*> : MapApplyGroup
infix operator <> : AppendGroup
