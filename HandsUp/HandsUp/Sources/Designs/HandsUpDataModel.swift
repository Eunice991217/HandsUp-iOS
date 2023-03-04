//
//  PostData.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/02/04.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// request
struct boards_rq: Codable {
    let indicateLocation: String
    let latitude: Double
    let longitude: Double
    let content, tag: String
    let messageDuration: Int
}

//reponse
struct boards_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct boards_delete_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}


struct fcmToken_rq: Codable {
    let fcmToken: String
}

struct fcmToken_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct delete_fcmToken_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String?
}

struct boards_like_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let board_like_list: [board_like]?
}

// MARK: - Result
struct board_like: Codable {
    var chatRoomIdx: Int
    var text, boardContent: String
    var character: Character
    var likeCreatedAt: String
    
    init(){
        chatRoomIdx = 1
        text = "아래 글에 제이님이 관심있어요"
        boardContent = "내일 저녁 드실 분??"
        character = Character.init()
        likeCreatedAt = "2023-01-24T13:40:02.504578"
    }
           
}

// MARK: - Character
struct Character: Codable {
    var eye, eyeBrow, nose, mouth: String
    var hair, hairColor, skinColor, backGroundColor: String
    var glasses: String?
    
    init(){
        eye = "1"
        eyeBrow = "1"
        nose = "1"
        mouth = "1"
        hair = "1"
        hairColor = "1"
        skinColor = "1"
        backGroundColor = "1"
    }
    
}

