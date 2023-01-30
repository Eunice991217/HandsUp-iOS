//
//  ServerAPI.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/29.
//

import Foundation
import Alamofire

class ServerAPI{
    
    static func nicknameDoubleCheck(vc: Sign_up_ViewController) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/nickname")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let uploadData = try! JSONEncoder().encode(nickname_rq(schoolName: vc.sign_upData_Sign_up.school, nickname: vc.nicknameTextField_Sign_up.text ?? ""))
        //request.httpBody = try? JSONEncoder().encode(nickname_rq(schoolName: vc.sign_upData_Sign_up.school, nickname: vc.nicknameTextField_Sign_up.text ?? ""))
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let output = try? JSONDecoder().decode(nickname_rp.self, from: data!) else {
                return
            }
            if output.statusCode == 2000{
                check = output.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        /*let semaphore = DispatchSemaphore(value: 0)
         let queue = DispatchQueue.global(qos: .utility)
         AF.request(request).responseString(queue:queue) { (response) in
         switch response.result {
         case .success:
         let rpData:nickname_rp = try! JSONDecoder().decode(nickname_rp.self, from: response.data!)
         if rpData.statusCode == 2000 {
         check = true
         }
         case .failure(_):
         print("ERROR")
         }
         semaphore.signal()
         }
         semaphore.wait()*/
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
            guard let output = try? JSONDecoder().decode(emailVerify_rp.self, from: data!) else {
                return
            }
            if output.statusCode == 2000{
                check = output.statusCode
                vc.vefifiedCode_Sign_up = output.result
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
        var check:Int = 0
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let output = try? JSONDecoder().decode(login_rp.self, from: data!) else {
                return
            }
            if output.statusCode == 2000{
                check = output.statusCode
                UserDefaults.standard.set(output.result.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(output.result.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(true, forKey: "login")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
}
