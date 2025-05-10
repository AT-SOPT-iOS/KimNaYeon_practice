//
//  AuthAPI.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/9/25.
//

import Foundation

enum AuthAPI {
    case signup(SignupRequestDTO)
    case signin(SigninRequestDTO)
    
    var baseURL: URL {
        return NetworkConstant.baseURL
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/api/v1/auth/signup"
        case .signin:
            return "/api/v1/auth/signin"
        }
    }
    
    var method: String {
        switch self {
        case .signup, .signin:
            return "POST"
        }
    }
    
    var headers: [String: String] {
        return ["Content-Type": "Application/json"]
    }
    
    var body: Data? {
        switch self {
        case .signup(let dto):
            return try? JSONEncoder().encode(dto)
        case .signin(let dto):
            return try? JSONEncoder().encode(dto)
        }
    }
    
    var request: URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
