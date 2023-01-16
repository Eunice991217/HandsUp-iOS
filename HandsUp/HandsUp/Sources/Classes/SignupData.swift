//
//  SignupData.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/11.
//

import Foundation

class SignupData{
    var policyAgreement : Bool
    var type : Int //0: email, 1: kakao, 2: apple, 3: google
    var school : String
    var email : String
    var PW : String
    var nickname : String
    var characterComponent : [Int]
    
    init(){
        policyAgreement = false
        type = 0
        school = ""
        email = ""
        PW = ""
        nickname = ""
        characterComponent = [0,0,0,0,0,0,0]
    }
    
    init(mode : Int){
        policyAgreement = false
        type = mode
        school = ""
        email = ""
        PW = ""
        nickname = ""
        characterComponent = [0,0,0,0,0,0,0]
    }
}
