//
//  HomeDataModel.swift
//  HandsUp
//
//  Created by 김민경 on 2023/02/07.
//

import Foundation

// MARK: - request
struct FAQ_rq: Codable {
    let contents: String
}

//MARK: - response
struct FAQ_rp: Codable {
    let isSuccess: Bool
    let statusCode: Int
    let message, result: String
}
