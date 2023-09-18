//
//  AppDelegate.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/05.
//

import UIKit
import NMapsMap
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NMFAuthManager.shared().clientId = "3w1kzr13wh"
        
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print(granted, error)
        }
        //firebase 초기화 세팅
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        
        Messaging.messaging().delegate = self
        
        
        return true
        
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
    
extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      /// 앱이 foreground  상태일 때 Push 받으면 alert를 띄워준다
        ///
      completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // 푸시알림 클릭시 화면 이동
        guard let apsData = userInfo["aps"] as? [String : AnyObject], let alertData = apsData["alert"] as? [String : Any] else { return
        }
                // 내가 필요한 pidx라는 데이터는 aps > alert > pidx 에 들어있었다.
        if let postIndex = alertData["body"] as? String, postIndex.contains("채팅이 도착하였습니다."){
            UserDefaults.standard.set("chat", forKey: "alarmOrChat")
            coordinateToChatVC()

        }
        else if let postIndex = alertData["body"] as? String, postIndex.contains("회원님의 핸즈업에 누군가 하트를 눌렀습니다."){
            UserDefaults.standard.set("alarm", forKey: "alarmOrChat")
            coordinateToAlarmVC()
            

        }
        
        
        // tell the app that we have finished processing the user’s action / response
        completionHandler()
    }
    private func coordinateToAlarmVC(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        let storyboard = UIStoryboard(name: "HandsUp", bundle: nil)
        let yourVC = storyboard.instantiateViewController(withIdentifier: "AlarmListViewController")
        
        
        let storyboard_1 = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard_1.instantiateViewController(withIdentifier: "Home")
        
        
        let navController = UINavigationController(rootViewController: yourVC)
        navController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    private func coordinateToChatVC(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        let storyboard = UIStoryboard(name: "HandsUp", bundle: nil)
        let yourVC = storyboard.instantiateViewController(withIdentifier: "ChatListViewController")
        
        
        let storyboard_1 = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard_1.instantiateViewController(withIdentifier: "Home")
        
        
        let navController = UINavigationController(rootViewController: yourVC)
        navController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func switchToNextScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
           let storyboard = UIStoryboard(name: "HandsUp", bundle: nil)
           let nextViewController = storyboard.instantiateViewController(withIdentifier: "AlarmListViewController")
           
        window.rootViewController = nextViewController
       }
}
    
    extension AppDelegate: MessagingDelegate {
        
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

            // TODO: - 디바이스 토큰을 보내는 서버통신 구현
            
            let result = PostAPI.updateFCMToken(fcmToken: fcmToken!)
            UserDefaults.standard.set(fcmToken!, forKey: "fcmToken")

            if(result == 2000){
                print("fcmtoken의 서버통신에 성공했습니다. ")
            }else{
                print("fcm token 실패")
            }
        }
        
        
    }

    
