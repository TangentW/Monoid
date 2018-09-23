//
//  Writer.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

struct Writer<T, W: Monoid> {
    let value: T
    let record: W
    
    func tell(_ record: W) -> Writer {
        return Writer(value: value, record: self.record <> record)
    }
    
    func listen() -> Writer<(T, W), W> {
        return .init(value: (value, record), record: record)
    }
}

// Functor
extension Writer {
    func map<O>(_ mapper: (T) -> O) -> Writer<O, W> {
        return .init(value: mapper(value), record: record)
    }
    
    static func <^> <O>(lhs: (T) -> O, rhs: Writer) -> Writer<O, W> {
        return rhs.map(lhs)
    }
}

// Applicatice
extension Writer {
    static func pure(_ value: T) -> Writer {
        return Writer(value: value, record: W.empty)
    }
    
    func apply<O>(_ writer: Writer<(T) -> O, W>) -> Writer<O, W> {
        let newValue = writer.value(value)
        return .init(value: newValue, record: record <> writer.record)
    }
    
    static func <*> <O>(lhs: Writer<(T) -> O, W>, rhs: Writer<T, W>) -> Writer<O, W> {
        return rhs.apply(lhs)
    }
}

// Monad
extension Writer {
    static func `return`(_ value: T) -> Writer {
        return pure(value)
    }
    
    func bind<O>(_ mapper: (T) -> Writer<O, W>) -> Writer<O, W> {
        let newWriter = mapper(value)
        return .init(value: newWriter.value, record: record <> newWriter.record)
    }
    
    static func >>- <O>(lhs: (T) -> Writer<O, W>, rhs: Writer<T, W>) -> Writer<O, W> {
        return rhs.bind(lhs)
    }
}
