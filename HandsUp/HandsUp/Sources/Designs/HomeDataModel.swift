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

//MARK: - response

// FAQ
struct FAQ_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}

// HomeList
struct HomeList_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message: String
    let result: HomeList_rp_result
}

struct HomeList_rp_result: Codable {
    let schoolName: String
    let getBoardList: [HomeList_rp_GetBoardList]
}

struct HomeList_rp_GetBoardList: Codable {
    let board: HomeList_rp_board
    let tag: String
}

struct HomeList_rp_board: Codable {
    let boardIdx: Int
    let content: String
    let latitude, longitude: Int
    let indicateLocation: String
    let messageDuration: Int
    let createdAt, updatedAt, status: String
}

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
