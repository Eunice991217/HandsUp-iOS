//
//  AppDelegate.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/05.
//

import UIKit
import NMapsMap
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NMFAuthManager.shared().clientId = "3w1kzr13wh"
        
        //firebase 초기화 세팅
        FirebaseApp.configure()
        
        //메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        //fcm 다시 사용 설정
        Messaging.messaging().isAutoInitEnabled = true
        
        //푸시 알림 권한 설정 및 푸시 알림에 앱 등록
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        application.registerForRemoteNotifications()
        
        // device token 요청.
        UIApplication.shared.registerForRemoteNotifications()
        
        
        return true
        
    }
    
    /// APN 토큰과 등록 토큰 매핑
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// 현재 등록 토큰 가져오기.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        // TODO: - 디바이스 토큰을 보내는 서버통신 구현
        
        let result = PostAPI.updateFCMToken(fcmToken: fcmToken!)
        if(result == 2000){
            print("fcmtok/Users/yunjiseong/Desktop/tcm_ex.apnsen!!!: \(fcmToken)")
            print("fcmtoken의 서버통신에 성공했습니다. ")
        }else{
            
        }
        
        let result_ = PostAPI.deleteFCMToken()
        if(result_ == 2000){
            print("fcmtoken 삭제 성공. ")
        }else{
            print("삭제 실패")
            print(result_)
        }
        
    
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

