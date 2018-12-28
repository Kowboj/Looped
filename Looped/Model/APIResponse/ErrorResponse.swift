struct ErrorResponse: Decodable {
    let errorMessage: ErrorMessage
}

struct ErrorMessage: Decodable {
    let code: String
    let description: String
}
