//
//  Response.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/3/25.
//

/// 회원가입
struct RegisterResponseWrapper: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: RegisterResponseBody
}

struct RegisterResponseBody: Codable {
    let userId: Int
    let nickname: String
}

/// 닉네임 조회
struct NicknameResponseWrapper: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: NicknameResponseBody
}

struct NicknameResponseBody: Codable {
    let nicknameList: [String]
}
