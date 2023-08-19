//
//  AppDelegate.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/05.
//

import UIKit
import NMapsMap
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
        // FirebaseMessaging: Firebase Core 설정 및 Messaging 딜리게이트 추가
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
extension AppDelegate: UNUserNotificationCenterDelegate {
    // foreground에서 시스템 푸시를 수신했을 때 해당 메소드가 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        // 푸시알림에 들어있는 데이터들
        let userInfo = response.notification.request.content.userInfo
        // 푸시알림 클릭시 화면 이동
        if let apsData = userInfo["aps"] as? [String : AnyObject] {
            if let alertData = apsData["alert"] as? [String : Any] {
                // 내가 필요한 pidx라는 데이터는 aps > alert > pidx 에 들어있었다.
                if let postIndex = alertData["body"] as? String {
                    // 현재 뷰컨트롤러 구하기
                    // 이동해야 하는 뷰컨트롤러
                    
                    if(postIndex.contains("채팅")){
                         coordinateToSomeVC(isLike: false)
                        switchToNextScreen()

                        
                    }
                    else if(postIndex.contains("하트")){
                         coordinateToSomeVC(isLike: true)
                        switchToNextScreen()

                        
                    }
                    
                    
                }
                
            }
        }
    }
    private func coordinateToSomeVC(isLike: Bool)
    {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = mainStoryboard.instantiateViewController(identifier: "Home")
        
        let handStoryboard = UIStoryboard(name: "HandsUp", bundle: nil)
        let yourVC = handStoryboard.instantiateViewController(identifier: "AlarmNChatListViewController")
        
        print("여기까진 되는거니?")
        if(isLike == false ){
        }
        else{
            print("되는거니?")
            let navController = UINavigationController(rootViewController: yourVC)
            navController.modalPresentationStyle = .fullScreen
            
            window.rootViewController = navController
            window.makeKeyAndVisible()
            
            NotificationCenter.default.post(name: Notification.Name("이름 설정"), object: nil, userInfo: ["index":3])
            
            
        }
    }


    func switchToNextScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
           let storyboard = UIStoryboard(name: "HandsUp", bundle: nil)
           let nextViewController = storyboard.instantiateViewController(withIdentifier: "AlarmNChatListViewController")
           
        window.rootViewController = nextViewController
       }

    
}




extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken: \(fcmToken)")
    }
    
}

