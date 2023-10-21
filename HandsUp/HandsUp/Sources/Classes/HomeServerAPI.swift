//
//  HomeServerAPI.swift
//  HandsUp
//
//  Created by 김민경 on 2023/02/07.
//

import Foundation
import Foundation
import Alamofire

class HomeServerAPI {
    
    static let lock: NSLock = NSLock()
    
    static func boardsHeart(boardIdx: Int64) -> Int{
        let url = URL(string: Server_Addr() + "/boards/\(boardIdx)/like")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = 0
        let session = URLSession(configuration: .default)
        
        let uploadData = try! JSONEncoder().encode(boardsHeart_rq(boardIdx: boardIdx)) // rq
        
        let semaphore = DispatchSemaphore(value: 0)
        
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("하트 요청 실패: \(error.localizedDescription)")
                check = -1
            } else if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    check = 2000
                    print("하트 요청에 성공하였습니다.")
                } else if statusCode == 400 {
                    check = 4000
                    print("하트 요청 존재하지 않는 이메일입니다.")
                } else if statusCode == 401 {
                    check = 4010
                    print("하트 요청 게시물 인덱스가 존재하지 않습니다.")
                } else {
                    check = statusCode
                    print("하트 요청 데이터베이스 저장 오류가 발생했습니다.")
                }
            }
            semaphore.signal() // 세마포어 시그널
        }.resume()

        
        semaphore.wait()
        return check
    }
    
    static func FAQ(contents: String) -> Int{
        let url = URL(string: Server_Addr() + "/help/inquiry")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        let uploadData = try! JSONEncoder().encode(FAQ_rq(contents: contents)) // rq
        
        var check:Int = 0
        let session = URLSession(configuration: .default)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        session.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(FAQ_rp.self, from: data!) // rp
            if output == nil{
                check = -1
            }else if output!.statusCode == 2000{
                check = output!.statusCode
                UserDefaults.standard.set(contents, forKey: "contents")
            }else{
                check = output!.statusCode
            }
            semaphore.signal() // 세마포어 시그널 
        }.resume()
        
        semaphore.wait()
        return check
    }
 
    static func boardsShowList() -> [boardsShowList_rp_getBoardList]?{
        
        self.lock.lock()
        defer {
            self.lock.unlock()
        }
        
        let url = URL(string: Server_Addr() + "/boards/showList/")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [boardsShowList_rp_getBoardList]? = nil
        var output: boardsShowList_rp? = nil
        let session = URLSession(configuration: .default)
                
        let semaphore = DispatchSemaphore(value: 0)
        
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(boardsShowList_rp.self, from: data!)
            if output == nil{
                check = -1;
                print("리스트 output message: \(output?.message)")
//                print("리스트 output 실패 result: \(output?.result)")
                print("리스트 output 실패: \(output?.statusCode)")
            }
            else{
                check = output!.statusCode
                print("리스트 output message: \(output?.message)")
//                print("리스트 output 성공 result: \(output?.result)")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(boardsShowList_rp.self, from: data!)
                    if output == nil{
                        check = -1;
                        print("check3 : \(check)")
                    }
                    else{
                        check = output!.statusCode
                        print("check4 : \(check)")
                    }
                    semaphore.signal()
                }.resume()
                semaphore.wait()
            }
        }
        
        if check == 2000{//서버 통신 성공
            rtn = output!.result!.getBoardList
            print("statusCode : \(output!.statusCode)")
        }
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func showMapList() -> [ShowMapList_rp_getBoardMap]?{
        
        self.lock.lock()
        defer {
            self.lock.unlock()
        }
        
        let url = URL(string: Server_Addr() + "/boards/showMapList")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [ShowMapList_rp_getBoardMap]? = nil
        var output: ShowMapList_rp? = nil
        let session = URLSession(configuration: .default)
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(ShowMapList_rp.self, from: data!)
            if output == nil{
                check = -1;
                print("지도 output message: \(output?.message)")
//                print("지도 output 실패 result: \(output?.result)")
                print("지도 output 실패: \(output?.statusCode)")
            }
            else{
                check = output!.statusCode
                print("지도 output message: \(output?.message)")
//                print("지도 output 성공 result: \(output?.result)")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        if check == 4044{
            if ServerAPI.reissue() == 2000{
                session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    output = try? JSONDecoder().decode(ShowMapList_rp.self, from: data!)
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
            rtn = output!.result.getBoardMap
        }
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    
}
