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
struct chat_create_rq: Codable{
    let boardIndx: Int
    let chatRoomKey: String
    
}

struct chat_create_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}

// MARK: - Message
struct Message: Codable {
    let id: String
    let content: String
    let sentDate: Date
    
    init(id: String, content: String) {
        self.id = id
        self.content = content
        self.sentDate = Date()
    }
    
    // MARK: - Date 형을 firestore에 입력하면 Unix Time Stamp형으로 변환하는 작업
        
        private enum CodingKeys: String, CodingKey {
            case id
            case content
            case sentDate
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey: .id)
            content = try values.decode(String.self, forKey: .content)
            
            let dataDouble = try values.decode(Double.self, forKey: .sentDate)
            sentDate = Date(timeIntervalSince1970: dataDouble)
        }
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

