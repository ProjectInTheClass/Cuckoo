//
//  Init_AddTagsView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine



struct Init_AddTagsView: View {
    var body: some View {
        VStack {
            HeaderView(title: "메모 태그를 등록해주세요")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .center, spacing: 30) {
                _profileView(prev: "득수네 메모장")
                
                BarDivider()
                
                AddTagFormView()
                    .frame(maxWidth: .infinity)
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            Spacer()
            ConfirmFixedButton(confirmMessage: "태그 추가 완료!")
                .frame(height: 120)
                .frame(maxWidth: .infinity)
        }
    }
}

struct Init_AddTagsView_Previews: PreviewProvider {
    static var previews: some View {
        Init_AddTagsView()
    }
}


// Components
struct _profileView: View {
    var prev : String

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            CardContent {
                VStack(spacing: 20) {
                    // TODO: 나중에 이미지 업로드 가능하게 변경 (Profile Image)
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                        .frame(width: 140, height: 140)
                    
                    HStack {
                        Spacer()
                        
                        Text(prev)
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                        
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

