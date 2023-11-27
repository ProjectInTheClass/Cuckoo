//
//  3_Init_AddInfoConfirmView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/26.
//

import SwiftUI
import Combine



struct Init_AddInfoConfirmView: View {
    @State private var buttonText = "등록 완료"
    @State private var headerTitle = "마지막 확인!"
    @State private var navigateToNextScreen = false
    @State private var isAtBottom = false
    @State private var scrollViewHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @Namespace var bottomID

    var body: some View {
        NavigationView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    HeaderView(title: headerTitle)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)

                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .center, spacing: 30) {
                            AddNameView()
                                .frame(maxWidth: .infinity)
                            
                            BarDivider()

                            AddTagFormView()
                                .frame(maxWidth: .infinity)
                            
                            BarDivider()
                            BarDivider()
                            
                            AddAlarmTermView()
                                .frame(maxWidth: .infinity)
                            
                            BarDivider()
                            BarDivider()
                        
                            AddAlarmPresetView(presetButtonList: presetButtonList)
                                .frame(maxWidth: .infinity)
                            
//                            GeometryReader { proxy in
//                                let offset = proxy.frame(in: .named("scroll")).minY
//                                Color.clear.preference(key: ViewOffsetKey.self, value: offset)
//                            }
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 120)
                        .frame(maxWidth: .infinity)
                        
                    }.coordinateSpace(name: "scroll")
                        .onPreferenceChange(ViewOffsetKey.self) { value in
                            print(value)
                        }

                    NavigationLink(destination: MainView(), isActive: $navigateToNextScreen) {
                        EmptyView()
                    }

                    
                }.navigationBarBackButtonHidden(true)
                .overlay(
                    
                    VStack{
                        Spacer()
                        ConfirmFixedButton(confirmMessage: buttonText)
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                navigateToNextScreen = true // 다음 화면으로 이동
                            }
                        
                    }, alignment: .leading)
                
            }.navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
}

// 스크롤 뷰의 위치를 추적하기 위한 Key 정의
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct Init_AddInfoConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        Init_AddInfoConfirmView()
    }
}
