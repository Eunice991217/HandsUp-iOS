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
            // 현재 디바이스의 시간대 가져오기
            let deviceTimeZone = TimeZone.current

            // 현재 시간을 디바이스의 시간대로 출력
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = deviceTimeZone
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let localTimeString = dateFormatter.string(from: currentDate)
            
            request.createdat = localTimeString
            print("현재 시간은 ? \(Date())")
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
    
    func readAll(chatRoomID: String, completion: @escaping ([Message]?, Error?) -> Void) {
        var messages: [Message] = []
        
        db.collection("chatroom/\(chatRoomID)/chat").order(by: "createdat", descending: false).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
                return
            }
            
            for document in querySnapshot!.documents {
                do {
                    if var varMessage = try? document.data(as: Message.self) {
                        varMessage.documentID = document.documentID
                        messages.append(varMessage)
                    } else {
                        print("Failed to decode message data for document \(document.documentID)")
                    }
                } catch {
                    print("Error decoding message data: \(error)")
                    completion(nil, error)
                    return
                }
            }
            
            completion(messages, nil)
        }
    }
    func deleteChat(chatRoomID: String, completion: @escaping (Error?) -> Void) {
        let collectionRef = db.collection("chatroom").document(chatRoomID).collection("chat")
        
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("컬렉션 조회 중 오류 발생: \(error)")
                completion(error)
            } else {
                let batch = self.db.batch()
                
                for document in snapshot!.documents {
                    let docRef = collectionRef.document(document.documentID)
                    batch.deleteDocument(docRef)
                }
                
                batch.commit { (error) in
                    if let error = error {
                        print("컬렉션 삭제 중 오류 발생: \(error)")
                        completion(error)
                    } else {
                        print("컬렉션 및 문서 삭제 성공")
                        completion(nil)
                    }
                }
            }
        }
    }

}






