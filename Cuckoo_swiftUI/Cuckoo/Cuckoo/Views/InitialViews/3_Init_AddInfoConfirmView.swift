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
    
    @EnvironmentObject var globalState: GlobalState

    var body: some View {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    HeaderView(title: headerTitle)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)

                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            
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
                            
                                AddAlarmPresetView()
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.top, 30)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 120)
                            .frame(maxWidth: .infinity)

                            
                            
                            Color.clear.frame(height:0).id(bottomID)
                        }
                    }
                }
                .overlay(
                    VStack{
                        Spacer()
                        ConfirmFixedButton(confirmMessage: buttonText)
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation {
                                    scrollViewProxy.scrollTo(bottomID, anchor: .top)
                                    
                                    if !navigateToNextScreen {
                                        navigateToNextScreen = true;
                                    } else {
                                        withAnimation {
                                            globalState.isRegistered = true;
                                        }
                                    }

                                }
                                
                                
                            }
                        
                    }, alignment: .leading)
                
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
