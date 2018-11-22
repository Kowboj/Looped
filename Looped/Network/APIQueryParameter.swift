public enum APIQueryParameter {
    case null
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
    case dictionary([String : APIQueryParameter])
}

extension APIQueryParameter: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .null:
            try container.encodeNil()
        case .string(let string):
            try container.encode(string)
        case .bool(let bool):
            try container.encode(bool)
        case .double(let double):
            try container.encode(double)
        case .dictionary(let dictionary):
            try dictionary.encode(to: encoder)
        case .int(let int):
            try container.encode(int)
        }
    }
    
}

extension APIQueryParameter: Equatable {
    public static func ==(lhs: APIQueryParameter, rhs: APIQueryParameter) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null):
            return true
        case (.int(let lhs), .int(let rhs)):
            return lhs == rhs
        case (.double(let lhs), .double(let rhs)):
            return lhs == rhs
        case (.bool(let lhs), .bool(let rhs)):
            return lhs == rhs
        case (.string(let lhs), .string(let rhs)):
            return lhs == rhs
        case (.dictionary(let lhs), .dictionary(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
