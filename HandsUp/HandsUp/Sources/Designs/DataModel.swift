//
//  DataModel.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/29.
//

import Foundation

// MARK: - request
struct nicknameCheck_rq: Codable{
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

struct nickname_rq: Codable {
    let nickname: String
}

struct editCharacter_rq: Codable{
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

struct reportBoard_rq: Codable{
    var content: String
    var boardIdx: Int
}

struct reportUser_rq: Codable{
    var content: String
    var userIdx: Int
}

//MARK: - response
struct nicknameCheck_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct emailVerify_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct makeCharacter_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: Int?
}

struct Sign_up_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct login_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: login_rp_result?
}

struct login_rp_result: Codable{
    let grantType, accessToken, refreshToken: String
    let accessTokenExpiresIn: Int
}

struct logout_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String?
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
    let message: String
    let result: String?
}


struct users_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: users_rp_result?
}

struct users_rp_result: Codable {
    let nickname, schoolName, eye, eyeBrow: String
    let glasses, nose, mouth, hair: String
    let hairColor, skinColor, backGroundColor: String
}

struct nickname_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String?
}

struct editCharacter_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct withdraw_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: withdraw_rp_result?
}

struct withdraw_rp_result: Codable{
    let userIdx: Int
}

struct reportBoard_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct reportUser_rp: Codable{
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct myBoards_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: myBoards_rp_result?
}

struct myBoards_rp_result: Codable {
    let character: myBoards_rp_character
    let myBoardList: [myBoards_rp_myBoardList]
}

struct myBoards_rp_character: Codable {
    let createdAt, updatedAt: String
    let characterIdx: Int
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor, status: String
}

struct myBoards_rp_myBoardList: Codable {
    let boardIdx: Int
    let status, content: String
    let latitude, longitude: Double
    let createdAt: String
    let location : String
}

struct boardsBlock_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct chatsBlock_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct singleList_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: singleList_rp_result?
}

struct singleList_rp_result: Codable {
    let nickname: String
    let latitude, longitude: Double
    let content, tag, didLike: String
    let messageDuration: Int
    let createdAt: String
    
}


//MARK: - return
struct boardsBlock_rtn{
    var statusCode: Int
    var result_mode: String?
}

struct chatsBlock_rtn{
    var statusCode: Int
    var result_mode: String?
}
