//
//  InitialView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine


struct HeaderView: View {
    var title: String;
    
    var body: some View {
        VStack {
                Spacer()
                Text(title)
                .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
        }
    }
}

struct InitialView: View {
    var body: some View {
        VStack {
            HeaderView(title: "누구인지 알려주세요!")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .center, spacing: 30) {
                ProfileView()
                    .frame(maxWidth: .infinity)
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            Spacer()
            ConfirmFixedButton(confirmMessage: "프로필 입력 완료!")
                .frame(height: 120)
                .frame(maxWidth: .infinity)
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

// Components
struct ProfileView: View {
    @State private var userName: String = "사용자 이름"
    @State private var textFieldSize: CGSize = .zero
    @FocusState private var isEditing: Bool

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
                        TextField("메모장 이름", text: $userName)
                            .focused($isEditing)
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                            .underline(isEditing)
                            .scaledToFit()
                        
                        Spacer()
                    }
                }
            }
            
            // BarDivider()
        }
    }
}




struct InitialCardContent<Content: View>: View {
    var child: Content
    init(@ViewBuilder content: () -> Content) {
        self.child = content()
    }
    
    var body: some View {
        child
    }
}

struct InitialCardTitleText: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            Spacer()
        }
    }
}

struct BarDivider: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(width: .infinity, height: 0.2)
      .overlay(
        Rectangle()
          .stroke(
            Color(red: 0, green: 0, blue: 0).opacity(0.10), lineWidth: 0.50
          )
      );
  }
}


struct ConfirmFixedButton: View {
    var confirmMessage: String
    
    var body: some View {
        VStack {
                Text(confirmMessage)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.purple)
        .cornerRadius(15)
        .padding(.horizontal, 30)

    }
}
