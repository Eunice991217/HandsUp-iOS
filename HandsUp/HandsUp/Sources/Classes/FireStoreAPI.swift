//
//  FireStoreAPI.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/03/08.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Codable {
    
    // @DocumentID가 붙은 경우 Read시 해당 문서의 ID를 자동으로 할당
    @DocumentID var documentID: String?
    
//    // @ServerTimestamp가 붙은 경우 Create, Update시 서버 시간을 자동으로 입력함 (FirebaseFirestoreSwift 디펜던시 필요)
//    @ServerTimestamp var serverTS: Timestamp?
    
    var content: String
    var authorUID: String = ""
    var createdat: String = ""
    
    // 왼쪽: Swift 내에서 사용하는 변수이름 / 오른쪽: Firebase에서 사용하는 변수이름
    enum CodingKeys: String, CodingKey {
        case documentID = "document_id"
        case createdat = "createdat"
        case authorUID = "author_uid"
        
        case content = "content"
    }
}


final class FirestoreAPI {
    static let shared = FirestoreAPI()

    var db: Firestore!
    var chatRoomRef: CollectionReference!
    
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        // [END setup]
        db = Firestore.firestore()
        
    }
    
    func addChat(chatRoomID: String, chatRequest request: Message) {
        chatRoomRef = db.collection("chatroom/\(chatRoomID)/chat")
            var ref: DocumentReference? = nil
            
            do {
                ref = chatRoomRef.document()
                guard let ref = ref else {
                    print("Reference is not exist.")
                    return
                }
                
                var request = request
                request.createdat = Date().toString()
                request.authorUID =  UserDefaults.standard.string(forKey: "email")!
                
                try ref.setData(from: request) { err in
                    if let err = err {
                        print("Firestore>> Error adding document: \(err)")
                        return
                    }
                    
                    print("Firestore>> Document added with ID: \(ref.documentID)")
                }
            } catch  {
                print("Firestore>> Error from addPost-setData: ", error)
            }
        }
    func readAll(chatRoomID: String, completionHandler: @escaping ([Message]) -> Void) {
        chatRoomRef = db.collection("chatroom/\(chatRoomID)/chat")

        chatRoomRef.getDocuments() { (querySnapshot, err) in
            var messages:[Message] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {return}
                let decoder =  JSONDecoder()
                
                for document in documents {
                    
                    do {
                        let data = document.data()
                        print("createdat: \(data["createdat"]) content: \(data["content"]) author_uid: \(data["author_uid"])")
                        let jsonData = try JSONSerialization.data(withJSONObject:data)
                        print(jsonData)
                        let roadInfo = try decoder.decode(Message.self, from: jsonData)
                        messages.append(roadInfo)
                        
                        if let createdat = String(data["createdat"]) as? String, let content = data["content"] as? String, let author_uid = data["author_uid"] as? String{
                            
                            let newMessage = Message(content: content, authorUID: author_uid, createdat: createdat)
                            messages.append(newMessage)
                            
                            
                        }
                        
                    } catch let err {
                        print("err: \(err)")
                    }
                }
                print("개수: \(documents.count )")
                completionHandler(messages)
            }
        }
    }
    
}

