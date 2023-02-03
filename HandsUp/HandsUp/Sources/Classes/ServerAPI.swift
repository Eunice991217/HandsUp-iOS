//
//  ServerAPI.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/29.
//

import Foundation
import Alamofire
import UIKit

class ServerAPI{
    static func nicknameDoubleCheck(vc: Sign_up_ViewController) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/nickname")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let uploadData = try! JSONEncoder().encode(nickname_rq(schoolName: vc.sign_upData_Sign_up.school, nickname: vc.nicknameTextField_Sign_up.text ?? ""))
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            if data == nil{
                check = -1
            }else{
                guard let output = try? JSONDecoder().decode(nickname_rp.self, from: data!) else {
                    return
                }
                if output.statusCode == 2000{
                    check = output.statusCode
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func emailVerify(vc: Sign_up_ViewController,email: String) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/certify")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let uploadData = try! JSONEncoder().encode(emailVerify_rq(email: email))
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            if data == nil{
                check = -1
            }else{
                guard let output = try? JSONDecoder().decode(emailVerify_rp.self, from: data!) else {
                    return
                }
                if output.statusCode == 2000{
                    check = output.statusCode
                    vc.vefifiedCode_Sign_up = output.result
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func makeCharacter(vc:Sign_up_ViewController)->Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/create/character")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let backGroundColor = String(vc.sign_upData_Sign_up.characterComponent[0] + 1)
        let hair = String(vc.sign_upData_Sign_up.characterComponent[1] + 1)
        let eyeBrow = String(vc.sign_upData_Sign_up.characterComponent[2] + 1)
        let mouth = String(vc.sign_upData_Sign_up.characterComponent[3] + 1)
        let nose = String(vc.sign_upData_Sign_up.characterComponent[4] + 1)
        let eye = String(vc.sign_upData_Sign_up.characterComponent[5] + 1)
        let glasses: String
        if vc.sign_upData_Sign_up.characterComponent[5] == 0{
            glasses = ""
        }else{
            glasses = String(vc.sign_upData_Sign_up.characterComponent[6])
        }
        let hairColor = ""
        let skinColor = ""
        let uploadData = try! JSONEncoder().encode(makeCharacter_rq(eye: eye, eyeBrow: eyeBrow, glasses: glasses, nose: nose, mouth: mouth, hair: hair, hairColor: hairColor, skinColor: skinColor, backGroundColor: backGroundColor))
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(makeCharacter_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.result
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func sign_up(data: SignupData, charIDX: Int)->Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/signup")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let uploadData = try! JSONEncoder().encode(sign_up_rq(email: data.email, password: data.PW, nickname: data.nickname, characterIdx: charIDX, schoolName: data.school))
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(Sign_up_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else {
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func login(email: String, pw: String) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let uploadData = try! JSONEncoder().encode(login_rq(email: email, password: pw))
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(login_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
                UserDefaults.standard.set(output!.result.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(output!.result.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(pw, forKey: "pw")
                UserDefaults.standard.set(true, forKey: "login")
            }
            else{
                check = output!.statusCode
                UserDefaults.standard.set(false, forKey: "login")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
}
