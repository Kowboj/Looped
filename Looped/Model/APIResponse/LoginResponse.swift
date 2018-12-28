struct LoginResponse: Decodable {
    let token_type: String
    let refresh_token_expires_in: TimeInterval?
    let refresh_token: String?
    let scope: String
    let resource_owner: String?
    let expires_in: TimeInterval
    let access_token: String
}
