//
//  YouTubeTokenResponse.swift
//  Vivace
//
//  Created by Carlos Lopez on 5/11/21.
//

public struct TokenResponse: Codable, Equatable {
    public let accessToken: String
    public let expiresIn: Int
    public let idToken: String
    public let scope: String
    public let tokenType: String
    public let refreshToken: String?
}
