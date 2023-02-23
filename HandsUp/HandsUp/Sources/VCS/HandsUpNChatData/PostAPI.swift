//
//  PostAPI.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/02/05.
//

import Foundation
import Alamofire

class PostAPI{
    static func makeNewPost( indicateLocation : String, latitude : Double, longitude : Double, content : String, tag : String, messageDuration : Int) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")

        let uploadData = try! JSONEncoder().encode(boards_rq(indicateLocation: indicateLocation, latitude: latitude, longitude: longitude, content: content, tag: tag, messageDuration: messageDuration))
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(boards_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func editPost(indicateLocation : String, latitude : Double, longitude : Double, content : String, tag : String, messageDuration : Int, boardIdx: String)-> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/{\(boardIdx)}")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")

        let uploadData = try! JSONEncoder().encode(boards_rq(indicateLocation: indicateLocation, latitude: latitude, longitude: longitude, content: content, tag: tag, messageDuration: messageDuration))
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(boards_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func deletePost(boardIdx: Int)-> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/delete/\(boardIdx)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")


        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(boards_delete_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func updateFCMToken( fcmToken: String) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/update-fcmToken")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")

        let uploadData = try! JSONEncoder().encode(fcmToken_rq(fcmToken: fcmToken))
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(fcmToken_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func deleteFCMToken()-> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/users/delete-fcmToken")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")

        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(delete_fcmToken_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
}
