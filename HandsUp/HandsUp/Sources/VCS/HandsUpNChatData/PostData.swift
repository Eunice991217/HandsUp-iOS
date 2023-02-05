//
//  PostData.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/02/04.
//

import Foundation

struct PostData: Codable {
    var indicateLocation : String
    var locaton_PD : String
    var content : String
    var tag : String
    var messageDuration : Int
}
