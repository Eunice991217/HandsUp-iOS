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
        
        let board_request = boards_rq(indicateLocation: indicateLocation, latitude: latitude, longitude: longitude, content: content, tag: tag, messageDuration: messageDuration)
        
        let uploadData = try! JSONEncoder().encode(board_request)
        
        
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
 
    static func showBoardsLikeList() -> [board_like]?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/like")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [board_like]? = nil
        var output: boards_like_rp? = nil
        let session = URLSession(configuration: .default)
       
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(boards_like_rp.self, from: data!)
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
                    output = try? JSONDecoder().decode(boards_like_rp.self, from: data!)
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
            rtn = output!.board_like_list
        }
        
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func makeNewChat(boardIndx : Int, chatRoomKey: String) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/create")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let uploadData = try! JSONEncoder().encode(chat_create_rq(boardIndx: boardIndx, chatRoomKey: chatRoomKey))
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(chatsBlock_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }
            else if output!.statusCode == 4055{
                print("이미 존재하는 채팅방입니다. ")
                check = output!.statusCode
            }
            else{ // statusCode = 4000 존재하지 않는 이메일입니다. , statusCode = 4010 게시물 인덱스가 존재하지 않습니다.
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return check
    }
    
    static func getChatList() -> [Chat]?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/list")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [Chat]? = nil
        var output: chat_list_rp? = nil
        let session = URLSession(configuration: .default)
       
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(chat_list_rp.self, from: data!)
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
                    output = try? JSONDecoder().decode(chat_list_rp.self, from: data!)
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
            rtn = output!.chatList
        }else{
            print("채팅리스트 통신 실패 statuscode: \(check)")
        }
        
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func getBoardInChat(chatRoomKey: String) -> board_in_chat_result?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/\(chatRoomKey)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: board_in_chat_result? = nil
        var output: board_in_chat_rp? = nil
        let session = URLSession(configuration: .default)
       
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(board_in_chat_rp.self, from: data!)
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
                    output = try? JSONDecoder().decode(board_in_chat_rp.self, from: data!)
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
            rtn = output!.result
        }else{
            print("채팅내 게시물 : \(check)")
        }
        
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
}

