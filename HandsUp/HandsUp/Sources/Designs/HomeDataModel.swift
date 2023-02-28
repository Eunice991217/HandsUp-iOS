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
    let tag: String
}

struct boardsShowList_rp_board: Codable {
    let boardIdx: Int
    let content: String
    let latitude, longitude: Int
    let indicateLocation: String
    let messageDuration: Int
    let createdAt, updatedAt, status: String
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
    let character: ShowMapList_rp_character
    let latitude, longitude: Double
    let createdAt, tag: String
}

struct ShowMapList_rp_character: Codable {
    let eye, eyeBrow, glasses, nose: String
    let mouth, hair, hairColor, skinColor: String
    let backGroundColor: String
}
