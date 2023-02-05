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

struct sign_up_rq: Codable{
    let email: String
    let password: String
    let nickname: String
    let characterIdx: Int
    let schoolName: String
}


struct login_rq: Codable{
    let email, password: String
}

struct password_rq: Codable{
    let currentPwd, newPwd: String
}

struct reissue_rq: Codable {
    let grantType, accessToken, refreshToken: String
    let accessTokenExpiresIn: Int
}

//MARK: - response
struct nickname_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}

struct emailVerify_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}

struct makeCharacter_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: Int
}

struct Sign_up_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}

struct login_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: login_rp_result
}

struct login_rp_result: Codable{
    let grantType, accessToken, refreshToken: String
    let accessTokenExpiresIn: Int
}

struct logout_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}

struct reissue_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: reissue_rp_result
}

struct reissue_rp_result: Codable {
    let grantType, accessToken, refreshToken: String
    let accessTokenExpiresIn: Int
}

struct password_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}


struct users_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: users_rp_result
}

struct users_rp_result: Codable {
    let nickname, eye, eyeBrow, glasses: String
    let nose, mouth, hair, hairColor: String
    let skinColor, backGroundColor: String
}

