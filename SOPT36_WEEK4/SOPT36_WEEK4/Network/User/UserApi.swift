//
//  UserApi.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/9/25.
//

import Foundation

enum UserAPI {
    case getMyNickname(userId: String)
    case getNicknameList(keyword: String?)
    case editNickname(EditNicknameRequestDTO)
    
    var baseURL: URL {
        return NetworkConstant.baseURL
    }
    
    var path: String {
        switch self {
        case .getMyNickname:
            return "/api/v1/users/me"
        case .getNicknameList, .editNickname:
            return "/api/v1/users"
        }
    }
    
    var method: String {
        switch self {
        case .getMyNickname, .getNicknameList:
            return "GET"
        case .editNickname:
            return "PATCH"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getMyNickname(let userId):
            return [
                "Content-Type": "Application/json",
                "userId": userId
            ]
        case .getNicknameList, .editNickname:
            return ["Content-Type": "Application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getMyNickname, .editNickname:
            return nil
        case .getNicknameList(let keyword):
            guard let keword = keyword, !keword.isEmpty else { return nil }
            return [URLQueryItem(name: "keyword", value: keword)]
        }
    }
    
    var body: Data? {
        switch self {
        case .getMyNickname, .getNicknameList:
            return nil
        case .editNickname(let dto):
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
