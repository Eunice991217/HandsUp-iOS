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
    let latitude, longitude: Double?
    let content, tag: String
    let messageDuration: Int
    let location : String
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
    let result: board_like?
}

// MARK: - Result
struct board_like: Codable {
    let receivedLikeInfo: [ReceivedLikeInfo]
    let hasNext: Bool
}

// MARK: - ReceivedLikeInfo
struct ReceivedLikeInfo: Codable {
    let boardIdx: Int
    let emailFrom, text, boardContent: String
    let character: Character
    let boardUserIdx: Int
    let likeCreatedAt: String
}

// MARK: - Character
struct Character: Codable {
    var eye, eyeBrow, nose, mouth: String
    var hair, hairColor, skinColor, backGroundColor: String
    var glasses: String?
    
}
struct chat_create_rq: Codable{
    let boardIdx: Int64
    let chatRoomKey: String
    let oppositeEmail: String?
}

struct chat_create_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}

//채팅 목록 받아오는 API 관련 구조체
struct chat_list_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: [Chat]?
}
struct Chat: Codable{
    let chatRoomIdx: Int
    let chatRoomKey: String
    let boardIdx: Int
    let character: chatCharacter
    let nickname, updatedAt, lastContent, lastSenderEmail: String
    let notRead: Int
    let oppositeEmail: String
}

struct chatCharacter: Codable {
    let createdAt, updatedAt: String
    let characterIdx: Int
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor, status: String
}


struct board_in_chat_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: board_in_chat_result
}

// MARK: - Result
struct board_in_chat_result: Codable {
    let board: board_in_chat
    let tag: String
    let character: chatCharacter
    let writerEmail: String
    let nickname: String
}

// MARK: - Board
struct board_in_chat: Codable {
    let boardIdx: Int
    let content: String
    let latitude, longitude: Double
    let location, indicateLocation: String
    let messageDuration: Int
    let createdAt, updatedAt, status: String
}

struct chat_alarm_rq: Codable {
    let email: String
    let chatContent: String
    let chatRoomKey: String
}

struct chat_alarm_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: String
}
struct chats_read_rq: Codable {
    let chatRoomKey: String
}

struct chats_read_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
}
struct message {
    let date: String
    let content: String
}



extension Encodable {
    // message 구조체를 firebase에 저장될 수 있는 dictionary로 바꾸는 과정.
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}

struct chat_check_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: chatCheckResult
}

// MARK: - Result
struct chatCheckResult: Codable {
    let board: chatCheckBoard
    let character: chatCheckCharacter
    let nickname: String
    let writerEmail: String
    let isSaved: Bool
}

// MARK: - Board
struct chatCheckBoard: Codable {
    let boardIdx: Int
    let content: String
    let latitude, longitude: Double
    let location, indicateLocation: String
    let messageDuration: Int
    let createdAt, updatedAt, status: String
}

// MARK: - Character
struct chatCheckCharacter: Codable {
    let createdAt, updatedAt: String
    let characterIdx: Int
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor, status: String
}


