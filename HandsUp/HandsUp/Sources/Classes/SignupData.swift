//
//  SignupData.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/11.
//

import Foundation

class SignupData{
    var school : String
    var email : String
    var PW : String
    var nickname : String
    var characterComponent : [Int]
    
    init(){
        school = ""
        email = ""
        PW = ""
        nickname = ""
        characterComponent = [0,0,0,0,0,0,0]
    }
}
