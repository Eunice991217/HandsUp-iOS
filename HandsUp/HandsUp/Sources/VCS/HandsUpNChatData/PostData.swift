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
