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
    
}
