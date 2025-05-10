//
//  AuthService.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/9/25.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    private init() {}
    
    func signup(with dto: SignupRequestDTO) async throws -> SignupResponseDTO {
        let api = AuthAPI.signup(dto)
        let (data, response) = try await URLSession.shared.data(for: api.request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(APIResponse<SignupResponseDTO>.self, from: data)
            guard let decodedData = decoded.data else {
                throw NetworkError.responseDecodingError
            }
            return decodedData
        } catch {
            print("디코딩 실패", error)
            throw NetworkError.responseDecodingError
        }
    }
    
    func signin(with dto: SigninRequestDTO) async throws -> SigninResponseDTO {
        let api = AuthAPI.signin(dto)
        let (data, response) = try await URLSession.shared.data(for: api.request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(APIResponse<SigninResponseDTO>.self, from: data)
            guard let decodedData = decoded.data else {
                throw NetworkError.responseDecodingError
            }
            return decodedData
        } catch {
            print("디코딩 실패", error)
            throw NetworkError.responseDecodingError
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}
