//
//  Identifier.swift
//
//  Created by Yauhen Rusanau on 6/18/20.
//

import Foundation

public protocol HasIdentifier {
    associatedtype RawIdentifier: Codable, Hashable = String
    var id: Identifier<Self> { get }
}

public enum Identifier<T: HasIdentifier>: Hashable {
    public typealias RawID = T.RawIdentifier
    case new(RawID)
    case existing(RawID)
}

public extension Identifier {
    var isNew: Bool {
        if case .new = self {
            return true
        }
        else {
            return false
        }
    }
    
    var rawIdentifier: RawID {
        switch self {
        case .new(let raw): return raw
        case .existing(let raw): return raw
        }
    }
}

public extension Identifier where RawID == String {
    static func new() -> Identifier {
        .new(UUID().uuidString)
    }
}

public extension Identifier where RawID == UUID {
    static func new() -> Identifier {
        .new(UUID())
    }
}

public extension Identifier where RawID: Equatable {
    func isEqual(to raw: RawID) -> Bool {
        if case .existing(let identifier) = self {
            return identifier == raw
        }
        else {
            return false
        }
    }
}

extension Identifier: Encodable where RawID: Encodable {}
extension Identifier: Decodable where RawID: Decodable {}
