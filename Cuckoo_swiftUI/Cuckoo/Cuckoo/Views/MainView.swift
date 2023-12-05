//
//  MainView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI


struct MainView: View {
    
    //title 수정용
    @State private var isPresentingMemoSheet = false
    @State private var newMemoTitle = ""
    @State private var newMemoDetails = ""
    
    
    //메모들을 위한 item
    // TODO : <og:preview> tag에서 미리보기 이미지 떼오는 hook
    let items: [Memo] = [
        Memo(
            id: 1,
            userId: 1,
            title: "PM 스터디 그것이 알고싶다",
            comment: "우아한 형제들 Tech 블로그 나중에 꼭 챙겨보기!",
            url: URL(string: "https://www.naver.com"),
            thumbURL: URL(string: "https://s.pstatic.net/static/www/mobile/edit/2016/0705/mobile_212852414260.png"),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 3, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        ),
        Memo(
            id: 2,
            userId: 1,
            title: "오늘 할일",
            comment: "1. 방 옷 정리하기\n2. 동사무소 16시 이전에 들렸다오기\n3. 소모임 관련 Notion 페이지 손보기",
            url: URL(string: ""),
            thumbURL: URL(string: ""),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 3, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        ),
        Memo(
            id: 3,
            userId: 1,
            title: "Velog",
            comment: "내가 보려고 정리한 기술 블로그 모음(2022)",
            url: URL(string: "https://velog.io/@esthevely/%EB%82%B4%EA%B0%80-%EB%B3%B4%EB%A0%A4%EA%B3%A0-%EC%A0%95%EB%A6%AC%ED%95%9C-%EA%B8%B0%EC%88%A0-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%AA%A8%EC%9D%8C2022"),
            thumbURL: URL(string: "https://velog.velcdn.com/images/esthevely/post/af9eda09-5d6e-464b-91e7-ad14fa2d1e3f/tumblr_nn2mjjJKzq1utwqnuo1_500.gif"),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 3, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        ),
        Memo(
            id: 4,
            userId: 1,
            title: "Github",
            comment: "클린코드 스터디",
            url: URL(string: "https://github.com/Yooii-Studios/Clean-Code"),
            thumbURL: URL(string: "https://opengraph.githubassets.com/d3065dfb6924c24f6f7ff79247bb370fccdf88295c564036ddfd3c5a19c29057/Yooii-Studios/Clean-Code"),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 3, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        ),
        Memo(
            id: 5,
            userId: 1,
            title: "Velog",
            comment: "참고하려고 하는 TIL 관련 게시글!",
            url: URL(string: "https://velog.io/@moonstar/TIL-22.12.29"),
            thumbURL: URL(string: "https://images.velog.io/velog.png"),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 2, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        )
    ]
    
    
    var itemCount: Int {
        return items.count
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing:10){
                // Header
                MainViewHeader(itemCount: itemCount)
                Spacer()
                
                // Search Bar & Tag
                MainViewSearchFilter()
                Spacer()
                
                // Body
                ScrollView {
                    ForEach(items, id: \.id) { item in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: MemoDetailView(viewModel: MemoDetailViewModel(memo: item))) {
                                MainContainerView(memo: item)
                            }.padding(.vertical, 15)
                            
                            
                            Divider()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .overlay(
                    AddMemoFloatingButton(),
                    alignment: .bottomTrailing
                )
                
            }.padding(.horizontal, 30)
        }
    }
}


struct MainView_PreViews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// Components

struct MainViewHeader: View {
    var itemCount: Int
    
    @State private var text = "Initial Text"
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination:SettingView()){
                    Image(systemName:"gearshape.circle.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .foregroundColor(Color.cuckooNormalGray)
                        .padding(.trailing,10)
                }
                NavigationLink(destination: AlarmView()){
                    Image(systemName:"bell.circle.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .foregroundColor(Color.cuckooNormalGray)
                }
            }
            Spacer()
        }.frame(height: 80)
        
        
        //Title
        VStack{
            HStack(spacing:0) {
                if isEditing {
                    TextField("Edit text", text: $text)
                        .border(Color.gray, width: 1)
                        .padding()
                } else {
                    VStack(alignment: .leading,spacing: 0){
                        Text("득수의 메모장")
                            .font(.system(size: 30, weight: .heavy))
                            .lineSpacing(130)
                            .kerning(-0.03)
                            .multilineTextAlignment(.leading)
                        Text("\(itemCount)개의 메모")
                            .font(.system(size:12, weight: .regular))
                            .lineSpacing(52)
                            .kerning(0)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    }
                    
                }
                Spacer()
            }
        }
    }
}

struct MainViewSearchFilter: View {
    @State private var searchContent: String = "" // 사용자가 입력할 내용을 저장할 상태 변수입니다.
    
    var body: some View {
        // TextEditor의 스크롤 가능한 영역 설정
        VStack(spacing: 18) {
            HStack(spacing: 0){
                TextField("검색어를 입력해주세요!", text: $searchContent)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.leading, 25)
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 36, alignment: .top)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.defaultPure, lineWidth: 1)).opacity(0.5)
                    
                
            }
            .onAppear (perform : UIApplication.shared.hideKeyboard)
            .overlay(Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
                .foregroundColor(.gray)
                     , alignment: .leading)
        
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<10) { index in
                        CardContent {
                            HStack {
                                TypeBubble("메모", "#b2b2b2")
                                TypeBubble("기록", "#b2b2b2")
                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct AddMemoFloatingButton: View {
    var body: some View {
        // Floating Action Button
        NavigationLink(destination:AddMemoView()){
            Image(systemName: "pencil")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.cuckooNormalGray)
        .clipShape(Circle())
        .padding(.bottom, 16) // Adjust the bottom padding as needed
        
    }
}
