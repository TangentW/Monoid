//
//  Validation.swift
//  Monoid
//
//  Created by Tangent on 2018/9/23.
//  Copyright © 2018 Tangent. All rights reserved.
//

enum Validation<T, E: Monoid> {
    case success(T)
    case failure(E)
}

extension Validation {
    var value: T? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    
    var error: E? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
}

// Functor
extension Validation {
    func map<O>(_ mapper: (T) -> O) -> Validation<O, E> {
        switch self {
        case .failure(let error): return .failure(error)
        case .success(let value): return .success(mapper(value))
        }
    }
    
    static func <^> <O>(lhs: (T) -> O, rhs: Validation) -> Validation<O, E> {
        return rhs.map(lhs)
    }
}

// Applicative
extension Validation {
    static func pure(_ value: T) -> Validation {
        return .success(value)
    }
    
    func apply<O>(_ validation: Validation<(T) -> O, E>) -> Validation<O, E> {
        switch (self, validation) {
        case (.failure(let errorL), .failure(let errorR)):
            return .failure(errorL <> errorR)
        case (.failure(let error), _):
            return .failure(error)
        case (_, .failure(let error)):
            return .failure(error)
        case (.success(let value), .success(let mapper)):
            return .success(mapper(value))
        }
    }
    
    static func <*> <O>(lhs: Validation<(T) -> O, E>, rhs: Validation<T, E>) -> Validation<O, E> {
        return rhs.apply(lhs)
    }
}

// Monad
extension Validation {
    static func `return`(_ value: T) -> Validation {
        return pure(value)
    }
    
    func bind<O>(_ mapper: (T) -> Validation<O, E>) -> Validation<O, E> {
        switch self {
        case .failure(let error): return .failure(error)
        case .success(let value): return mapper(value)
        }
    }
    
    static func >>- <O>(lhs: (T) -> Validation<O, E>, rhs: Validation) -> Validation<O, E> {
        return rhs.bind(lhs)
    }
}
