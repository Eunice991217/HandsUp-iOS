//
//  HomeDataModel.swift
//  HandsUp
//
//  Created by 김민경 on 2023/02/07.
//

import Foundation

// MARK: - request

// FAQ
struct FAQ_rq: Codable {
    let contents: String
}

struct boardsShowList_rq: Codable{
    let schoolName: String
}

struct showMapList_rq: Codable{
    let schoolName: String
}

//MARK: - response

// FAQ
struct FAQ_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}

//struct board_like: Codable {
//    var chatRoomIdx: Int
//    var text, boardContent: String
//    var character: Character
//    var likeCreatedAt: String
//
//    init(){
//        chatRoomIdx = 1
//        text = "아래 글에 제이님이 관심있어요"
//        boardContent = "내일 저녁 드실 분??"
//        character = Character.init()
//        likeCreatedAt = "2023-01-24T13:40:02.504578"
//    }
//
//}
//

// boardsShowList
struct boardsShowList_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: boardsShowList_rp_result?
}

struct boardsShowList_rp_result: Codable {
    let schoolName: String
    let getBoardList: [boardsShowList_rp_getBoardList]
}

struct boardsShowList_rp_getBoardList: Codable {
    let board: boardsShowList_rp_board
    let character: boardsShowList_rp_character
    let nickname: String
    let tag: String
    
    init() {
        board = boardsShowList_rp_board.init()
        character = boardsShowList_rp_character.init()
        nickname = "깅깅이"
        tag = "전체"
    }
}

struct boardsShowList_rp_board: Codable {
    let boardIdx: Int
    let content: String
    let latitude, longitude: Double
    let indicateLocation: String
    let messageDuration: Int
    let createdAt, updatedAt, status: String
    
    init() {
        boardIdx = 10
        content = "테스트입니당."
        latitude = 37.406284
        longitude = 127.116425
        indicateLocation = "true"
        messageDuration = 30
        createdAt = "2023-01-24T13:40:02.504578"
        updatedAt = "2023-03-07T12:18:52.870419"
        status = "ACTIVE"
    }
}

struct boardsShowList_rp_character: Codable {
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor: String
    
    init(){
        eye = "1"
        eyeBrow = "1"
        nose = "1"
        mouth = "1"
        hair = "1"
        hairColor = "1"
        skinColor = "1"
        glasses = "1"
        backGroundColor = "1"
    }
}

//showMapList
struct ShowMapList_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: ShowMapList_rp_result
}

struct ShowMapList_rp_result: Codable {
    let schoolName: String
    let getBoardMap: [ShowMapList_rp_getBoardMap]
}

struct ShowMapList_rp_getBoardMap: Codable {
    let boardIdx: Int
    let nickname: String
    let character: ShowMapList_rp_character
    let latitude, longitude: Double
    let createdAt, tag: String
}

struct ShowMapList_rp_character: Codable {
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor: String
}


struct BoardsHeart_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}
