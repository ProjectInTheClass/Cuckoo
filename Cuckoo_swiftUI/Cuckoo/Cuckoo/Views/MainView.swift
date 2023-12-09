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
    
    // TODO : <og:preview> tag에서 미리보기 이미지 떼오는 hook
    
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
                NavigationLink(destination: NotificationLogView()){
                    Image(systemName:"bell.circle.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .foregroundColor(Color.cuckooNormalGray)
                }
            }
            Spacer()
        }.frame(height: 80)
            .onAppear {
                NetworkManager.shared.memo_provider.request(.loadMemo(type: "uuid", identifier: "86be72a7-9cae-42e1-ab57-b6d7a0df07b3")) { result in
                    switch result {
                    case .success(let response):
                        print("Response data: \(response.data)")
                    case .failure(let error):
                        print("네트워크 에러: \(error)")
                    }
                }
            }
        
        
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
