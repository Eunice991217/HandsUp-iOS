//
//  FireStoreAPI.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/03/08.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class FirestoreAPI {
    
    let db = Firestore.firestore()
    
    private var documentListener: ListenerRegistration?
    
    //Firebase에 채팅방을 저장하는 메소드
    func makeNewChatRoom(chatID: String){
        // Document id 직접 작성하여 데이터 추가 (setdata는 데이터 추가만! 수정 안됨)
        db.collection("chats").document(chatID).setData([:]) { err in
            if let err = err {
                print(err)
            } else {
                print("Success")
            }
        }
    }
    //Firebase에 채팅 메세지들을 저장하는 메소드
    func saveChatMessage(chatID: String, _ message: Message ){
        let collectionPath = "chats/\(chatID)/chat"
            let collectionListener = Firestore.firestore().collection(collectionPath)
            
            guard let dictionary = message.asDictionary else {
                print("decode error")
                return
            }
        //addDoucment 키 값 자동 생성
            collectionListener.addDocument(data: dictionary) { error in
                if let error = error{
                    print(error)
                }else{
                    print("succesfully save message")
                }
            }
    }
    //Firestore에 접근하여 실시간으로 데이터를 가져오는 함수
    func subscribe(id: String) {
        let collectionPath = "chats/\(id)/chat" //데이터를 가져올 firestore 주소
        removeListener()
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
     
    }
    
    func removeListener() {
        documentListener?.remove()
    }
}
