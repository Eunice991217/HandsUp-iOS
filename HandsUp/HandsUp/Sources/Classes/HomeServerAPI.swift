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
    
    static func boardsHeart(boardIdx: Int) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/\(boardIdx)/like")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check:Int = 0
        let session = URLSession(configuration: .default)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let output = try? JSONDecoder().decode(BoardsHeart_rp.self, from: data!) // rp
            if output == nil{
                check = -1
            }else if output!.statusCode == 2000{
                check = output!.statusCode
            }else{
                check = output!.statusCode
            }
            semaphore.signal() // 세마포어 시그널
        }.resume()
        
        semaphore.wait()
        return check
    }
    
    static func FAQ(contents: String) -> Int{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/help/inquiry")
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
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/showList")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [boardsShowList_rp_getBoardList]? = nil
        var output: boardsShowList_rp? = nil
        let session = URLSession(configuration: .default)
        let uploadData = try! JSONEncoder().encode(boardsShowList_rq(schoolName: UserDefaults.standard.string(forKey: "schoolName")!))
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request,from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            output = try? JSONDecoder().decode(boardsShowList_rp.self, from: data!)
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
                    output = try? JSONDecoder().decode(boardsShowList_rp.self, from: data!)
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
            rtn = output!.result!.getBoardList
        }
        
        return rtn
        // rtn이 nil이면 서버 통신 실패 Or 데이터 없음
    }
    
    static func showMapList() -> [ShowMapList_rp_getBoardMap]?{
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/showMapList")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        
        var check: Int = -1
        var rtn: [ShowMapList_rp_getBoardMap]? = nil
        var output: ShowMapList_rp? = nil
        let session = URLSession(configuration: .default)
        let uploadData = try! JSONEncoder().encode(showMapList_rq(schoolName: UserDefaults.standard.string(forKey: "schoolName")!))
        let semaphore = DispatchSemaphore(value: 0)
        session.uploadTask(with: request,from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
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
