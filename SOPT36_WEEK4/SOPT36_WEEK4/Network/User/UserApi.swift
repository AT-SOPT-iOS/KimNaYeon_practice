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
    case editNickname(EditNicknameRequestDTO, userId: String)
    
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
        case .getMyNickname(let userId), .editNickname(_, let userId):
            return [
                "Content-Type": "Application/json",
                "userId": userId
            ]
        case .getNicknameList:
            return ["Content-Type": "Application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getMyNickname, .editNickname:
            return nil
        case .getNicknameList(let keyword):
            guard let keword = keyword, !keword.isEmpty else { return nil }
            return [URLQueryItem(name: "keyword", value: keyword)]
        }
    }
    
    var body: Data? {
        switch self {
        case .getMyNickname, .getNicknameList:
            return nil
        case .editNickname(let dto, _):
            return try? JSONEncoder().encode(dto)
        }
    }
    
    var request: URLRequest {
        var urlString = baseURL.appendingPathComponent(path).absoluteString
        
        if case . getNicknameList(let keyword) = self,
           let keyword = keyword, !keyword.isEmpty,
           let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString += "?keyword=\(encoded)"
        }
        guard let url = URL(string: urlString) else {
            fatalError("잘못된 URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
