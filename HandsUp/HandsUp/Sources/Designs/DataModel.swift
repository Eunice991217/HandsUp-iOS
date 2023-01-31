//
//  DataModel.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/29.
//

import Foundation

// MARK: - request
struct nickname_rq: Codable{
    let schoolName: String
    let nickname: String
}

struct emailVerify_rq: Codable{
    let email: String
}

struct makeCharacter_rq: Codable{
    var eye: String
    var eyeBrow: String
    var glasses: String
    var nose: String
    var mouth: String
    var hair: String
    var hairColor: String
    var skinColor: String
    var backGroundColor: String
}

struct login_rq: Codable{
    let email: String
    let password: String
}

//MARK: - response
struct nickname_rp: Decodable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}

struct emailVerify_rp: Decodable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}

struct makeCharacter_rp: Decodable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: Int
}

struct login_rp: Decodable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: login_rp_result
}

struct login_rp_result: Decodable{
    let grandType: String
    let accessToken: String
    let refreshToken: String
    let accessTokenExpiresIn: Int
}

