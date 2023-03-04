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
        let uploadData = try! JSONEncoder().encode(nicknameCheck_rq(schoolName: vc.sign_upData_Sign_up.school, nickname: vc.nicknameTextField_Sign_up.text ?? ""))
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(nicknameCheck_rp.self, from: data!)
            if output == nil{
                check = -1
            }else{
                check = output!.statusCode
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
            let output = try? JSONDecoder().decode(emailVerify_rp.self, from: data!)
            if output == nil{
                check = -1
            }else if output!.statusCode == 2000{
                check = output!.statusCode
                vc.vefifiedCode_Sign_up = output!.result!
            }else{
                check = output!.statusCode
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
                check = output!.result!
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
                UserDefaults.standard.set(output!.result!.grantType, forKey: "grantType")
                UserDefaults.standard.set(output!.result!.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(output!.result!.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(output!.result!.accessTokenExpiresIn, forKey: "accessTokenExpiresIn")
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
        
        if(check == 2000){
            check = users()
        }
        
        return check
    }
    
    static func logout() -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/logout")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(logout_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(logout_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{
            UserDefaults.standard.set(false, forKey: "login")
            PostAPI.deleteFCMToken()
        }
        return check
    }
    
    static func password(newPwd: String) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/password")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        let uploadData = try! JSONEncoder().encode(password_rq(currentPwd: UserDefaults.standard.string(forKey: "pw")!, newPwd: newPwd))
        
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(password_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
                UserDefaults.standard.set(newPwd, forKey: "pw")
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(password_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 2000{
                        check = output!.statusCode
                        UserDefaults.standard.set(newPwd, forKey: "pw")
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        return check
    }
    
    
    static func reissue() -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/reissue")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let grantType = UserDefaults.standard.string(forKey: "grantType") ?? ""
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        let accessTokenExpiresIn = UserDefaults.standard.integer(forKey: "accessTokenExpiresIn")
        
        let uploadData = try! JSONEncoder().encode(reissue_rq(grantType: grantType, accessToken: accessToken, refreshToken: refreshToken, accessTokenExpiresIn: accessTokenExpiresIn))
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(reissue_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
                UserDefaults.standard.set(output!.result.grantType, forKey: "grantType")
                UserDefaults.standard.set(output!.result.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(output!.result.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(output!.result.accessTokenExpiresIn, forKey: "accessTokenExpiresIn")
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func users() -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(users_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
                let glasses: Int = output!.result!.glasses == "" ? 0 : Int(output!.result!.glasses)!
                
                UserDefaults.standard.set(output!.result!.nickname, forKey: "nickname")
                UserDefaults.standard.set(output!.result!.schoolName,forKey: "schoolName")
                UserDefaults.standard.set(Int(output!.result!.backGroundColor)! - 1,forKey: "backgroundColor")
                UserDefaults.standard.set(Int(output!.result!.hair)! - 1,forKey: "hair")
                UserDefaults.standard.set(Int(output!.result!.eyeBrow)! - 1,forKey: "eyeBrow")
                UserDefaults.standard.set(Int(output!.result!.mouth)! - 1,forKey: "mouth")
                UserDefaults.standard.set(Int(output!.result!.nose)! - 1,forKey: "nose")
                UserDefaults.standard.set(Int(output!.result!.eye)! - 1,forKey: "eye")
                UserDefaults.standard.set(glasses,forKey: "glasses")
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(users_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 2000{
                        check = output!.statusCode
                        let glasses: Int = output!.result!.glasses == "" ? 0 : Int(output!.result!.glasses)!
                        
                        UserDefaults.standard.set(output!.result!.nickname, forKey: "nickname")
                        UserDefaults.standard.set(output!.result!.schoolName,forKey: "schoolName")
                        UserDefaults.standard.set(Int(output!.result!.backGroundColor)! - 1,forKey: "backgroundColor")
                        UserDefaults.standard.set(Int(output!.result!.hair)! - 1,forKey: "hair")
                        UserDefaults.standard.set(Int(output!.result!.eyeBrow)! - 1,forKey: "eyeBrow")
                        UserDefaults.standard.set(Int(output!.result!.mouth)! - 1,forKey: "mouth")
                        UserDefaults.standard.set(Int(output!.result!.nose)! - 1,forKey: "nose")
                        UserDefaults.standard.set(Int(output!.result!.eye)! - 1,forKey: "eye")
                        UserDefaults.standard.set(glasses,forKey: "glasses")
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        return check
    }
    
    static func nickname(nickname: String) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/nickname")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let uploadData = try! JSONEncoder().encode(nickname_rq(nickname: nickname))
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(nickname_rp.self, from: data!)
            if output == nil{
                check = -1
            }else if output!.statusCode == 2000{
                check = output!.statusCode
                UserDefaults.standard.set(nickname, forKey: "nickname")
            }else{
                check = output!.statusCode
            }
            
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(nickname_rp.self, from: data!)
                    if output == nil{
                        check = -1
                    }else if output!.statusCode == 2000{
                        check = output!.statusCode
                        UserDefaults.standard.set(nickname, forKey: "nickname")
                    }else{
                        check = output!.statusCode
                    }
                    
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        return check
    }
    
    static func editCharacter(characterComponent:[Int])->Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/character")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let backGroundColor = String(characterComponent[0] + 1)
        let hair = String(characterComponent[1] + 1)
        let eyeBrow = String(characterComponent[2] + 1)
        let mouth = String(characterComponent[3] + 1)
        let nose = String(characterComponent[4] + 1)
        let eye = String(characterComponent[5] + 1)
        let glasses: String
        if characterComponent[5] == 0{
            glasses = ""
        }else{
            glasses = String(characterComponent[6])
        }
        let hairColor = ""
        let skinColor = ""
        let uploadData = try! JSONEncoder().encode(editCharacter_rq(eye: eye, eyeBrow: eyeBrow, glasses: glasses, nose: nose, mouth: mouth, hair: hair, hairColor: hairColor, skinColor: skinColor, backGroundColor: backGroundColor))
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(editCharacter_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else {
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(editCharacter_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else {
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{
            let userDefaultsKey:[String] = ["backgroundColor", "hair", "eyeBrow", "mouth", "nose", "eye", "glasses"]
            var index:Int = 0
            userDefaultsKey.forEach{
                UserDefaults.standard.set(characterComponent[index], forKey: $0)
                index += 1
            }
        }
        
        return check
    }
    
    static func withdraw()->Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/withdraw")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = -1
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(withdraw_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else {
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(withdraw_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else {
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
            }
        }
        return check
    }
    
    static func reportBoard(content: String, boardIdx: Int) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/help/report/board")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = -1
        var output: reportBoard_rp? = nil
        let session = URLSession(configuration: .default)
        let uploadData = try! JSONEncoder().encode(reportBoard_rq(content: content, boardIdx: boardIdx))
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request,from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(reportBoard_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(reportBoard_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{
            //output!.result
        }
        
        return check
    }
    
    static func reportUser(content: String, userIdx: Int) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/help/report/user")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = -1
        var output: reportUser_rp? = nil
        let session = URLSession(configuration: .default)
        let uploadData = try! JSONEncoder().encode(reportUser_rq(content: content, userIdx: userIdx))
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request,from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(reportUser_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(reportUser_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{
            //output!.result
        }
        
        return check
    }
    
    static func myBoards() -> [myBoards_rp_myBoardList]?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/myBoards")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [myBoards_rp_myBoardList]? = nil
        var output: myBoards_rp? = nil
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(myBoards_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(myBoards_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{//서버 통신 성공
            rtn = output!.result!.myBoardList
        }
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 or 데이터 없음
    }
    
    static func boardsBlock(boardIdx: Int) -> boardsBlock_rtn{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/block/" + String(boardIdx))
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: boardsBlock_rtn = boardsBlock_rtn(statusCode: -1)
        var output: boardsBlock_rp? = nil
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(boardsBlock_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(boardsBlock_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        rtn.statusCode = check
        rtn.result_mode = output!.result
        
        return rtn
    }
    
    static func chatsBlock(chatRoomIdx: Int) -> chatsBlock_rtn{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/block/" + String(chatRoomIdx))
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: chatsBlock_rtn = chatsBlock_rtn(statusCode: -1)
        var output: chatsBlock_rp? = nil
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(chatsBlock_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(chatsBlock_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        rtn.statusCode = check
        rtn.result_mode = output!.result
        
        return rtn
    }
}
