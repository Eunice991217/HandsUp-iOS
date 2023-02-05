//
//  PostAPI.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/02/05.
//

import Foundation
import Alamofire

class PostAPI{
    static func postData(indicateLocation: String, location: String, content: String, tag: String, messageDuration: Int) -> Int {
        let serverDir = "http://13.124.196.200:8080"
        let url = URL(string: serverDir + "/boards/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var check:Int = 0

        let newPostData = try! JSONEncoder().encode(PostData(indicateLocation: indicateLocation, locaton_PD: location, content: content,  tag: tag, messageDuration: messageDuration))
        
        request.timeoutInterval = 10
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: newPostData, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
                
            case .failure(let error):
                print("error : \(error.errorDescription!)")
                check = -1
            }
            
            
        }
        return check
    }
}
