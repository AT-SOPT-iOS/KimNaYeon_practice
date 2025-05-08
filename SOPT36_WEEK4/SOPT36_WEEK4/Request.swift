//
//  Request.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/3/25.
//

struct RegisterRequestBody: Codable {
    let loginId: String
    let password: String
    let nickname: String
}
