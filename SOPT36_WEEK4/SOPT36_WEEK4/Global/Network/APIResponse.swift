//
//  APIResponse.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/9/25.
//

struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: T?
}
