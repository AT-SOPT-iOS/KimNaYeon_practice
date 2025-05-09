//
//  UserService.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/9/25.
//

import Foundation

class UserService {
    static let shared = UserService()
    private init() {}
    
    private struct EmptyResponseDTO: Codable {}

    func fetchNicknameList(keyword: String?) async throws -> NicknameListResponseDTO {
        let api = UserAPI.getNicknameList(keyword: keyword)
        let (data, response) = try await URLSession.shared.data(for: api.request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError
        }
        
        do {
            let decoded = try JSONDecoder().decode(APIResponse<NicknameListResponseDTO>.self, from: data)
            guard let decodedData = decoded.data else {
                throw NetworkError.responseDecodingError
            }
            return decodedData
        } catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
    
    func fetchMyNickname(userId: String) async throws -> MyNicknameResponseDTO {
        let api = UserAPI.getMyNickname(userId: userId)
        let (data, response) = try await URLSession.shared.data(for: api.request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError
        }
        
        do {
            let decoded = try JSONDecoder().decode(APIResponse<MyNicknameResponseDTO>.self, from: data)
            guard let decodedData = decoded.data else {
                throw NetworkError.responseDecodingError
            }
            return decodedData
        } catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
    
    func editNickname(with dto: EditNicknameRequestDTO) async throws {
        let api = UserAPI.editNickname(dto)
        let (data, response) = try await URLSession.shared.data(for: api.request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError
        }
        
        do {
            let decoded = try JSONDecoder().decode(APIResponse<EmptyResponseDTO>.self, from: data)
            return
        } catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
}
