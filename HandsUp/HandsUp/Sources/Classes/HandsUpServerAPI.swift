//
//  PostAPI.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/02/05.
//

import Foundation
import Alamofire

class PostAPI{
    static func makeNewPost( indicateLocation : String, latitude : Double, longitude : Double, content : String, tag : String, messageDuration : Int, location : String) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        var latitiude_1: Double = 0
        var longitude_1: Double = 0
        if(indicateLocation == "false"){
            latitiude_1  = 0
            longitude_1 = 0
        }
        else{
            latitiude_1  = latitude
            longitude_1 = longitude
        }
        let board_request = boards_rq(indicateLocation: indicateLocation, latitude: latitiude_1, longitude: longitude_1, content: content, tag: tag, messageDuration: messageDuration, location : location)
        
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
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
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
            }
        }
        return check
    }
    
    static func editPost(indicateLocation : String, latitude : Double, longitude : Double, content : String, tag : String, messageDuration : Int, boardIdx: Int, location : String)-> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/" + String(boardIdx))
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let uploadData = try! JSONEncoder().encode(boards_rq(indicateLocation: indicateLocation, latitude: latitude, longitude: longitude, content: content, tag: tag, messageDuration: messageDuration, location : location))
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(boards_rp.self, from: data!)
            if output == nil{
                check = -1;
                print("nil 입니다. ")
            }
            else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal()
            print(output!.message)
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(boards_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                        print("nil 입니다. ")
                    }
                    else if output!.statusCode == 2000{
                        check = output!.statusCode
                    }else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                    print(output!.message)
                }.resume()
                semaphore.wait()
            }
        }
        return check
    }
    
    static func deletePost(boardIdx: Int)-> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/delete/" + String(boardIdx))
        
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
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
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
            }
        }
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
            print("fcm token: \(output?.message)")
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
        
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(fcmToken_rp.self, from: data!)
                    print("fcm token: \(output?.message)")
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
            }
        }
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
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
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
            }
        }
        return check
    }
    
    static func showBoardsLikeList() -> board_like?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/like/30/")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: board_like? = nil
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
            rtn = output!.result
            
        }
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func makeNewChat(boardIndx : Int64, chatRoomKey: String) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/create")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        
        let uploadData = try! JSONEncoder().encode(chat_create_rq(boardIdx: boardIndx, chatRoomKey: chatRoomKey, oppositeEmail: nil))
        
        
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
                print("채팅방 생성에 성공했습니다.")
            }
            else{ // statusCode = 4000 존재하지 않는 이메일입니다. , statusCode = 4010 게시물 인덱스가 존재하지 않습니다.
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(chatsBlock_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 2000{
                        check = output!.statusCode
                        print("채팅방 생성에 성공했습니다.")
                    }
                    else{ // statusCode = 4000 존재하지 않는 이메일입니다. , statusCode = 4010 게시물 인덱스가 존재하지 않습니다.
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        return check
    }
    
    static func makeNewChat(boardIndx : Int64, chatRoomKey: String, oppositeEmail: String) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/create")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        
        let uploadData = try! JSONEncoder().encode(chat_create_rq(boardIdx: boardIndx, chatRoomKey: chatRoomKey, oppositeEmail: oppositeEmail))
        
        
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
                print("채팅방 생성에 성공했습니다.")
            }
            else{ // statusCode = 4000 존재하지 않는 이메일입니다. , statusCode = 4010 게시물 인덱스가 존재하지 않습니다.
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(chatsBlock_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 2000{
                        check = output!.statusCode
                        print("채팅방 생성에 성공했습니다.")
                    }
                    else{ // statusCode = 4000 존재하지 않는 이메일입니다. , statusCode = 4010 게시물 인덱스가 존재하지 않습니다.
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
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
            rtn = output!.result
        }else{
            print("채팅리스트 통신 실패 statuscode: \(check)")
        }
        
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func getBoardInChat(boardIdx: Int64) -> board_in_chat_rp?{
        let serverDir = "http://13.124.196.200:8080"
        
        //let url = URL(string: serverDir + "/chats/" + String(boardIdx) )
        let url = URL(string: serverDir + "/chats/" + String(boardIdx) )
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
        }else{
            print("채팅내 게시물 : \(check)")
        }
        return output
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    static func sendChatAlarm(emailID : String, chatContent: String, chatRoomKey: String ) -> Bool {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/alarm")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let uploadData = try! JSONEncoder().encode(chat_alarm_rq(email: emailID, chatContent: chatContent, chatRoomKey: chatRoomKey))
        

        var check:Int = -1;
        var rtn: Bool = false
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(chat_alarm_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 2000{
                rtn = true
            }
            else{
                check = output!.statusCode
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(chat_alarm_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 2000{
                        rtn = true
                    }
                    else{
                        check = output!.statusCode
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        return rtn
    }
    
    static func readChat(chatRoomkey : String){
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/read")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let chat_request = chats_read_rq(chatRoomKey: chatRoomkey)
        
        let uploadData = try! JSONEncoder().encode(chat_request)
        
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(chats_read_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else{
                check = output!.statusCode
                print("채팅 읽음 성공")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(chats_read_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else{
                        check = output!.statusCode
                        print("채팅 읽음 성공")
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
    }
    
    static func checkChatExists(chatRoomKey: String, boardIdx: Int, oppositeUserEmail: String) -> chat_check_rp?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/check-key/\(chatRoomKey)/" + String(boardIdx) + "/\(oppositeUserEmail)" )
        print("url: \(serverDir)/chats/check-key/\(chatRoomKey)/" + String(boardIdx) + "/\(oppositeUserEmail)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: chatCheckResult? = nil
        var output: chat_check_rp? = nil
        let session = URLSession(configuration: .default)
        
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(chat_check_rp.self, from: data!)
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
                    output = try? JSONDecoder().decode(chat_check_rp.self, from: data!)
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
            print("채팅 존재 check 통신 실패 statuscode: \(check)")
        }
        
        return output
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func deleteChat(chatRoomkey : String){
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/chats/\(chatRoomkey)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        
        var check:Int = -1;
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(deleteChat_rp.self, from: data!)
            if output == nil{
                check = -1;
            }
            else if output!.statusCode == 4011{
                print("유저 인덱스가 존재하지 않습니다. ")
            }
            else if output!.statusCode == 4017{
                print("채팅방이 존재하지 않습니다. ")
                check = output!.statusCode
            }
            else{
                check = output!.statusCode
                print("채팅 삭제 성공")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        
        if check == 4044{
            if ServerAPI.reissue() == 2000 {
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    let output = try? JSONDecoder().decode(deleteChat_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                    }
                    else if output!.statusCode == 4011{
                        print("유저 인덱스가 존재하지 않습니다. ")
                    }
                    else if output!.statusCode == 4017{
                        print("채팅방이 존재하지 않습니다. ")
                        check = output!.statusCode
                    }
                    else{
                        check = output!.statusCode
                        print("채팅 삭제 성공")
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
                
            }
        }
        
    }
    
    
}

