//
//  AlarmListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmListViewController: UIViewController{
    
    var likeList : [ReceivedLikeInfo] = []
    var characterList: [Int] = []
    //var beforeVC: ChatListViewController?
    let safeAreaView = UIView()
    var bomttomSafeAreaInsets: CGFloat = 0.0


    @IBOutlet weak var HomeTabView: UIView!

    @IBOutlet var homeBtnXConstraint: NSLayoutConstraint!
    @IBOutlet var bellBtnXConstraint: NSLayoutConstraint!
    // 테스트용 코드 지울것!
    var like_test: [board_like] = []
    
    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0

    
    @IBOutlet var redNotiOnBell: UIImageView!
    @IBOutlet var redNotiOnChat: UIImageView!

    @IBOutlet var alarmTableView_ALVC: UITableView!
    
    @IBAction func postBtnDidTap(_ sender: Any) {
        guard let registerPostVC = self.storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {
            return
        }
        // 화면 전환!
        self.present(registerPostVC, animated: true)
    }
    @IBAction func chatBtnDidTap(_ sender: Any) {

        guard let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController else { return  }

        chatVC.modalPresentationStyle = .fullScreen
        // 화면 전환!
        chatVC.beforeVC = self
        self.present(chatVC, animated: false)
        
    }
    func refresh(){
        likeList = PostAPI.showBoardsLikeList()?.receivedLikeInfo ?? []
        
        if hasNewerChat() || hasNewerAlarm() {
            redNotiOnBell.isHidden = false
        }else {
            redNotiOnBell.isHidden = true
        }
        if(hasNewerChat()){
            redNotiOnChat.isHidden = false
        }else{
            redNotiOnChat.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.size.width

        configureCustomView()

        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.safeAreaView)
        self.safeAreaView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.safeAreaView.heightAnchor.constraint(equalToConstant: bomttomSafeAreaInsets)
        ])

        HomeTabView.layer.shadowOpacity = 1
        HomeTabView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        HomeTabView.layer.shadowOffset = CGSize(width: 0, height: -8)
        HomeTabView.layer.shadowRadius = 24
        HomeTabView.layer.masksToBounds = false
        
        HomeTabView.clipsToBounds = false
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        homeBtnXConstraint.constant = screenWidth * 0.496
        bellBtnXConstraint.constant = screenWidth * 0.165
        
        
        alarmTableView_ALVC.delegate = self
        alarmTableView_ALVC.dataSource = self
        alarmTableView_ALVC.rowHeight = 98
        
        alarmTableView_ALVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        
        likeList = PostAPI.showBoardsLikeList()?.receivedLikeInfo ?? []
        if(likeList.count > 0){
            UserDefaults.standard.set(likeList[0].likeCreatedAt, forKey: "lastAlarmDate")
        }
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        
        if hasNewerChat() || hasNewerAlarm() {
            redNotiOnBell.isHidden = false
        }else {
            redNotiOnBell.isHidden = true
        }
        if(hasNewerChat()){
            redNotiOnChat.isHidden = false
        }else{
            redNotiOnChat.isHidden = true
        }
        
    }
    
    
    func showBlockAlert(errorContent: String){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: errorContent, attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func homeBtnDidTap(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                       
        // 스토리보드에서 지정해준 ViewController의 ID
        let homeVC_Login = storyboard!.instantiateViewController(withIdentifier: "Home")
        self.navigationController?.pushViewController(homeVC_Login, animated: false)
    }
    func configureCustomView() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let hasWindowScene = windowScene {
            bomttomSafeAreaInsets = hasWindowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
    }
    
    
    

}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return likeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        
        
        cell.timeLb_ATVC.text = formatDateString(likeList[indexPath.row].likeCreatedAt)
        //캐릭터 설정
        characterList = []
        let characterInAlarm = likeList[indexPath.row].character
        
        background = (Int(characterInAlarm.backGroundColor) ?? 1) - 1
        hair = (Int(characterInAlarm.hair) ?? 1) - 1
        eyebrow = (Int(characterInAlarm.eyeBrow) ?? 1) - 1
        mouth = (Int(characterInAlarm.mouth) ?? 1) - 1
        nose = (Int(characterInAlarm.nose) ?? 1) - 1
        eyes = (Int(characterInAlarm.eye) ?? 1) - 1
        glasses = Int(characterInAlarm.glasses ?? "1") ?? 0
        
        characterList.append(background)
        characterList.append(hair)
        characterList.append(eyebrow)
        characterList.append(mouth)
        characterList.append(nose)
        characterList.append(eyes)
        characterList.append(glasses)
        
        cell.characterView_ATVC.setAll(componentArray: characterList)
        cell.characterView_ATVC.setCharacter_NoShadow()
        cell.idLb_ATVC.text = "아래 글에 \(likeList[indexPath.row].nickname)님이 관심있어요"
        cell.contentLb_ATVC.text = likeList[indexPath.row].boardContent
         
        // 보내기 버튼 눌렀을 때 실행할 함수 선언
        cell.sendMessage = { [unowned self] in
            // 1. 새로운 채팅방 개설하기 위해 DB에 채팅 데이터 추가하는 함수 호출
            let boardIdx = likeList[indexPath.row].boardIdx
            
            // 채팅방 키(형식 = 게시물 인덱스 + 게시물 작성자 이메일 + 상대방 이메일)
            let chatRoomKey = String(boardIdx) + UserDefaults.standard.string(forKey: "email")! + likeList[indexPath.row].emailFrom

            let existResponse = PostAPI.checkChatExists(chatRoomKey: chatRoomKey, boardIdx: boardIdx, oppositeUserEmail: likeList[indexPath.row].emailFrom)

            // 채팅방 화면전환 관련 코드
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
            nextVC.modalPresentationStyle = .fullScreen
            
            // 2. DB 에서 요청 데이터 삭제하기
            switch existResponse?.statusCode ?? 0 {
            case 2000: // 채팅방 생성 성공 -> 해당 키로 화면 이동
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                view.window!.layer.add(transition, forKey: kCATransition)
                //채팅방 뷰컨에 게시물 키 전달
                nextVC.boardIdx = Int64(likeList[indexPath.row].boardIdx)
                nextVC.chatKey = chatRoomKey
                nextVC.partnerEmail = likeList[indexPath.row].emailFrom
                if existResponse?.result.isSaved == true{
                    nextVC.isChatExisted = true
                }
                nextVC.chatPersonName = likeList[indexPath.row].nickname
                nextVC.ismyBoard = true
                present(nextVC, animated: false, completion: nil)
                break
                
            case 4011: //존재하지 않는 유저이다. -> 팝업창
                showBlockAlert(errorContent: "존재하지 않는 사용자 입니다.")
                break
                
            case 4010: //존재하지 않는 게시물이다. -> 팝업창
                showBlockAlert(errorContent: "존재하지 않는 게시물입니다.")
                break
        
            default: // 서버 오류이다.
                ServerError()
                break
            }

            
        }
            
         
        
        return cell
    }
}

    

extension UIButton {
    var circleButton: Bool {
        set {
            
            if newValue {
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                
                self.backgroundColor = UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1)
            } else {
                self.layer.cornerRadius = 0
            }
        } get {
            return false
        }
    }
}
extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 24
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        
        
    }
}
extension String{
    func toDate() -> Date { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
               dateFormatter.timeZone = TimeZone(identifier: "UTC")
               if let date = dateFormatter.date(from: self) {
                   return date
               } else {
                   return Date() // 현재 날짜 출력하기
               }
    }
    
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    func getTimeDifference() -> String { // 경과 시간을 보여주는 함수
        var timeDiff = ""
        let currentDate = Date()
        let remainUTC = self.timeIntervalSince(currentDate)
        var minute: Int?
        var hour: Int?
        var create_year_string = ""
        
        var formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        var current_year_string = formatter_year.string(from: Date())
        
        if let modifiedDate = Calendar.current.date(byAdding: .hour, value: 9, to: self) {
            // 새로운 시간을 문자열로 포맷
            let modifiedDateString = formatter_year.string(from: modifiedDate)
            create_year_string = modifiedDateString
        }
        
        
        if(remainUTC < 60){ // 1분 보다 적은 시간일 때
            timeDiff = "방금 전"
        }
        else if(remainUTC < 3600 ) {// 1시간 보다 적은 시간일 떄
            minute = (Int)(remainUTC / 60)
            timeDiff = "\(String(describing: minute))분 전"
        }
        else if(remainUTC < 21600) { // 6시간 보다 적은 시간 경과
            hour = (Int)(remainUTC / 3600)
            timeDiff = "\(String(describing: hour))시간 전"
        }
        else if( current_year_string == create_year_string){ // 저장된 년도와 현재 년도가 같을 때
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd HH:mm"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            timeDiff =  dateFormatter.string(from: self)
        }
        else{ // 년도가 다를 때
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy/MM/dd HH:mm"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            timeDiff =  dateFormatter.string(from: self)
        }
        return timeDiff
    }
    func getDateToString() -> String{ // 저장 시간을 보여주는 함수
        let current = Calendar.current
        var date = ""
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy"
        
        var current_year_string = myDateFormatter.string(from: Date())
        var create_year_string = myDateFormatter.string(from: self)
        
        myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)

        if(current.isDateInToday(self)){//오늘이다.
            myDateFormatter.dateFormat = "a h시 m분"
        }
        else if(current.isDateInYesterday(self)){
            myDateFormatter.dateFormat = "어제"
        }
        else if(current_year_string == create_year_string){ // 올해일 때
            myDateFormatter.dateFormat = "M월 d일"
        }else{ // 작년부터 쭉 과거
            myDateFormatter.dateFormat = "yyyy. M. d."
        }
        date = myDateFormatter.string(from: self)
        return date
    }
    
    
     func isNew(fromDate: Date) -> Bool {
            var strDateMessage:Bool = false
            let result:ComparisonResult = self.compare(fromDate)
            switch result {
            case .orderedAscending:
                strDateMessage = true
                break
            default:
                strDateMessage = false
                break
            }
            return strDateMessage
        }
}
extension UIViewController{
    func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC") // UTC 시간대로 설정

        if let date = dateFormatter.date(from: dateString) {
            let koreanTimeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대로 설정
            dateFormatter.timeZone = koreanTimeZone

            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)

            let currentDate = Date()
            let currentComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)

            let yearString: String
            if let year = components.year, let currentYear = currentComponents.year, year == currentYear {
                yearString = ""
            } else {
                yearString = "\(components.year ?? 0)/"
            }
            
            let monthString = String(format: "%02d", components.month ?? 0)
            let dayString = String(format: "%02d", components.day ?? 0)
            let hourString = String(format: "%02d", components.hour ?? 0)
            let minuteString = String(format: "%02d", components.minute ?? 0)

            if yearString.isEmpty {
                if let month = components.month {
                    if month == currentComponents.month {
                        let timeDifference = currentDate.timeIntervalSince(date)
                        if timeDifference < 60 {
                            return "방금 전"
                        } else if timeDifference < 3600 {
                            let minutes = Int(timeDifference / 60)
                            return "\(minutes)분 전"
                        } else if timeDifference < 21600 {
                            let hours = Int(timeDifference / 3600)
                            return "\(hours)시간 전"
                        }
                    }
                    return "\(monthString)/\(dayString) \(hourString):\(minuteString)"
                }
            }

            return "\(yearString)\(monthString)/\(dayString) \(hourString):\(minuteString)"
        }

        return ""
    }
    func formatDatetoString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC") // UTC 시간대로 설정

        if let date = dateFormatter.date(from: dateString) {
            let koreanTimeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대로 설정
            dateFormatter.timeZone = koreanTimeZone

            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)

            let currentDate = Date()
            let currentComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)

            let yearString: String
            if let year = components.year, let currentYear = currentComponents.year, year == currentYear {
                yearString = ""
            } else {
                yearString = "\(components.year ?? 0)/"
            }
            
            let monthString = String(format: "%02d", components.month ?? 0)
            let dayString = String(format: "%02d", components.day ?? 0)
            let hourString = String(format: "%02d", components.hour ?? 0)
            let minuteString = String(format: "%02d", components.minute ?? 0)

            if yearString.isEmpty {
                if let month = components.month {
                    if month == currentComponents.month{
                        let timeDifference = currentDate.timeIntervalSince(date)
                        if timeDifference < 60 {
                            return "방금 전"
                        } else if timeDifference < 3600 {
                            let minutes = Int(timeDifference / 60)
                            return "\(minutes)분 전"
                        } else if timeDifference < 172800 {
                            let hours = Int(timeDifference / 3600)
                            return "\(hours)시간 전"
                        }
                    }
                    return "\(monthString)/\(dayString) \(hourString):\(minuteString)"
                }
            }

            return "\(yearString)\(monthString)/\(dayString) \(hourString):\(minuteString)"
        }

        return ""
    }


    func hasNewerAlarm() -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        
        let storedDate = UserDefaults.standard.string(forKey: "lastAlarmDate") ?? ""
        let likeList = PostAPI.showBoardsLikeList()?.receivedLikeInfo ?? []
        
    
        
        if likeList.count == 0 {
            return false
        }
        else if storedDate == "" {
            return true
        }
        else{
            // 문자열 형식의 날짜를 Date 객체로 변환
            if let date1 = dateFormatter.date(from: likeList[0].likeCreatedAt), let date2 = dateFormatter.date(from: storedDate) {
                // 날짜 비교
                return date1 > date2 // 최신 알람이 있음
            } else {
                // 올바르지 않은 날짜 형식이거나 변환 실패 시 false 반환
                return false
            }
        }
    }
    
    func hasNewerChat() -> Bool {
        let chatArr = PostAPI.getChatList() ?? []
        var count: Int = 0
        
        let myEmail: String = UserDefaults.standard.string(forKey: "email") ?? ""
        for chat in chatArr {
            if(chat.lastSenderEmail != myEmail){
                count += chat.notRead
            }
        }
        if(count>0){
            return true
        }
        else{
            return false
        }

    }
}
