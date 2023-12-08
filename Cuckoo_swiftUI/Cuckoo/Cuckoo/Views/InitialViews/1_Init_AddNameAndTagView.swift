//
//  InitialView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine

struct Init_AddNameAndTagView: View {
    // 상태 관리를 위한 변수 추가
    @State private var showAddTagForm = false
    @State private var buttonText = "프로필 입력 완료!"
    @State private var headerTitle = "누구인지 알려주세요!"
    @State private var navigateToNextScreen = false

    var body: some View {
        NavigationView {
            VStack {
                // 헤더 제목을 상태 변수로 변경
                HeaderView(title: headerTitle, isRoot: true)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 30) {
                    AddNameView()
                        .frame(maxWidth: .infinity)
                    
                    BarDivider()

                    // 조건에 따라 AddTagFormView 표시
                    if showAddTagForm {
                        AddTagFormView()
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity)
                Spacer()
                
                NavigationLink(
                    destination: Init_AddAlarmPresetView(),
                    isActive: $navigateToNextScreen
                ) {
                    EmptyView()
                }

                // 버튼 클릭 시 액션 추가
                ConfirmFixedButton(confirmMessage: buttonText)
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        if !showAddTagForm {
                            withAnimation {
                                self.showAddTagForm.toggle()
                            }
                            self.buttonText = "태그 추가 완료"
                            self.headerTitle = "태그를 추가해주세요!"
                        } else {
                            // 다른 화면으로 이동
                            self.navigateToNextScreen = true
                        }
                    }
            }
        }
    }
}

struct Init_AddNameAndTagView_Previews: PreviewProvider {
    static var previews: some View {
        Init_AddNameAndTagView()
    }
}

// Components
struct AddNameView: View {
    @State private var userName: String = "메모장 이름"
    @FocusState private var isEditing: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            CardContent {
                VStack(spacing: 20) {
                    // TODO: 나중에 이미지 업로드 가능하게 변경 (Profile Image)
                    Image("DefaultPreview")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .cornerRadius(70)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                    
                    HStack {
                        Spacer()
                        
                        TextField("", text: $userName)
                            .focused($isEditing)
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                            .underline(isEditing)
                            .scaledToFit()
                        
                        Spacer()
                    }
                }
            }
            
        }
    }
}

// 태그를 나타내는 구조체 정의
struct Tag_init: Hashable {
    var name: String
    var color: String
}

struct AddTagFormView: View {
    @State private var tags: [Tag_init] = [
        Tag_init(name: "전체", color: "#b2b2b2"),
        Tag_init(name: "메모", color: "#b2b2b2"),
        Tag_init(name: "메모1", color: "#b2b2b2"),
        Tag_init(name: "메모2", color: "#b2b2b2"),
        Tag_init(name: "메모3", color: "#b2b2b2"),
        Tag_init(name: "메모4", color: "#b2b2b2"),
        // 추가 태그는 여기에
    ]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "등록된 메모 태그")
            CardContent {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tags, id: \.self) { tag in
                            TypeBubble(tag.name, tag.color)
                        }
                        
                        // TODO: '+' 버튼 토글 이벤트
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size:25, weight: .medium))
                            .foregroundColor(Color(red:100, green: 0, blue:0).opacity(0.9))
                            .onTapGesture {
                                // 여기에 버튼 토글 이벤트 처리 로직 추가
                            }
                    }
                }
            }
        }
    }
}
