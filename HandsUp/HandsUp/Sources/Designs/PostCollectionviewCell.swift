//
//  PostCollectionviewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/08/19.
//
import UIKit
import SwiftUI

struct PostCollectionviewCell: View {
    @State var showingSheet = false
    @State var nickname: String = "차라나"
    @State var schoolname: String = "동국대"
    @State var indicateLocation: Bool = false
    @State var location: String = "위치비밀"
    @State var tagName = "스터디"
    @State var time:String = "10분 전"
    @State var content: String = "제가 3시쯤 수업이 끝날거 같은데 3시 30에 학교근처에서 쌀국수 먹으실분 계신가요? 연락주세요😎"
    @State var islike: Bool = false
    @State var charcterArr: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    @State var bgType: Int = 1
    @State var headType: Int = 1
    @State var eyebrowType: Int = 1
    @State var mouthType: Int = 1
    @State var noseType: Int = 1
    @State var eyesType: Int = 1
    @State var glassesType: Int = 1
    
    
    var body: some View {
            VStack{
                ZStack(alignment: .top){
                    // 위 두개 학교 및 태그
                    HStack{
                        HStack(alignment: .top, spacing: 8) {
                            Text("# \(tagName)")
                                .font(
                                    Font.custom("Roboto", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.94, green: 0.48, blue: 0.09))
                        .cornerRadius(15)
                        
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text(schoolname)
                                .font(.custom("Roboto-Bold", size: 12)
                                )
                            .foregroundColor(.white)}
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .frame(width: 68, height: 24, alignment: .center)
                        .background(Color(red: 0.31, green: 0.49, blue: 0.75))
                        .cornerRadius(15)
                    }.offset(x: 0, y: -15).zIndex(1)
                    
                    
                    //가운데 하얀 네모
                    VStack(){
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Image("threeDotsHorizon")
                                    .frame(width: 34.70164, height: 33.78542)
                            }).actionSheet(isPresented: $showingSheet) {
                                ActionSheet(
                                    title: Text("Title"),
                                    buttons: [
                                        .default(Text("이 게시물 그만보기")),  .default(Text("신고하기")), .cancel()
                                    ])
                            }
                            
                        }
                        Text(nickname)
                            .font(
                                Font.custom("Roboto", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .frame(width: 59.96721, height: 21.63008, alignment: .topLeading).padding(.top, 24)
                        
                        HStack{
                            Text(nickname)
                                .font(
                                    Font.custom("Roboto", size: 12)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                            
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 1, height: 10)
                            
                            Text(indicateLocation ? location : "위치 비밀")
                                .font(
                                    Font.custom("Roboto", size: 12)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 1, height: 10)
                            
                            Text(time)
                                .font(
                                    Font.custom("Roboto", size: 12)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                        }
                        
                        MyUIChacracterView(boardsCharacterList: charcterArr).frame(width: 145, height: 145).padding(.top, 16)
                        Text(content).font(
                            Font.custom("Roboto", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                        .frame(width: 236.16393, alignment: .topLeading).padding(.top, 32)
                        
                        Spacer()
                        
                        
                        
                    } .foregroundColor(.clear)
                        .frame(width: 294, height: 490)
                        .background(.white)
                        .cornerRadius(20)
                    
                }
                HStack(alignment: .center){
                    
                    Button(action: {
                        
                    }, label: {
                        Image("xmarkInGreyCircle").resizable()
                            .aspectRatio(contentMode: .fill).frame(width:45, height: 45)
                    })
                    Spacer()
                    Button(action: {}, label: {
                        Image("send").resizable()
                            .aspectRatio(contentMode: .fill).frame(width:80, height: 80)
                    })
                    Spacer()
                    Button(action: {
                        islike.toggle()
                    
                    }, label: {
                        Image(islike ? "heartInWhiteCircle" : "HeartDidTap")
                            .resizable()
                                .aspectRatio(contentMode: .fill).frame(width:50, height: 50)
                    })

                }.padding(.top, 27).frame(width: 215)
            }.background(.regularMaterial).background(.black)
    
        }
}

struct MyUIChacracterView: UIViewRepresentable {
    @State var boardsCharacterList: [Int] = [1, 1, 1, 1, 1, 1, 1]
    
    func makeUIView(context: Context) -> Character_UIView {
        let view = Character_UIView()
        view.backgroundColor = .black
        DispatchQueue.main.async {
            view.setAll(componentArray: boardsCharacterList)
            
            view.eyesType = 1
            view.eyebrowType = 1
            view.noseType = 1
            view.mouthType = 1
            view.glassesType = 1
            view.headType = 1
            view.bgType = 1
            
            view.setCharacter()
        }
        
        
        //view.setCharacter(componentArray: boardsCharacterList)

        return view
    }
    func updateUIView(_ uiView: Character_UIView, context: Context) {
       
        uiView.eyesType = boardsCharacterList[0]
        uiView.eyebrowType = boardsCharacterList[1]
        uiView.noseType = boardsCharacterList[2]
        uiView.mouthType = boardsCharacterList[3]
        uiView.glassesType = boardsCharacterList[4]
        uiView.headType = boardsCharacterList[0]
        uiView.bgType = boardsCharacterList[0]
        uiView.setCharacter(componentArray: boardsCharacterList)
    }
    
}

struct labelView: UIViewRepresentable{

    @Binding var text: String // @Bidning property: SwiftUI -> UIKit으로의 데이터 전달
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textColor = .blue
        return label
    }
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

struct PostCollectionviewCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCollectionviewCell()
    }
}
