//
//  AddMemoView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/08.
//

import SwiftUI
import Combine

struct AddMemoHeaderView: View {
    var body: some View {
        VStack {
                Spacer()
                Text("메모 등록")
                .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
        }
    }
}

struct AddMemoView: View {
    var body: some View {
        NavigationView{
            VStack {
                AddMemoHeaderView()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 30) {
                    MemoTypeFormView()
                        .frame(maxWidth: .infinity)
                    
                    MemoContentFormView()
                        .frame(maxWidth: .infinity)
                    
                    MemoAlarmIntervalFormView()
                        .frame(maxWidth: .infinity)
                    
                    MemoPreView()
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity)
                Spacer()
                AddMemoFooterView()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
        }
        .tabItem {
            Image(systemName: "2.circle")
            Text("ADDMEMO")
        }
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}

// Components

struct MemoTypeFormView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 타입")
            CardContent {
                HStack {
                    TypeBubble("메모", "#b2b2b2")
                    TypeBubble("기록", "#b2b2b2")
                    InfoBubble(title: "5+")
                }
            }
        }
    }
}

struct MemoContentFormView: View {
    @State private var memoContent: String = "" // 사용자가 입력할 내용을 저장할 상태 변수입니다.
    private let maxCharacterLimit = 250

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 내용")
            CardContent {
                // TextEditor의 스크롤 가능한 영역 설정
                VStack(alignment: .leading, spacing: 0){
                    TextField("메모 디테일한 내용을 작성해주세요.", text: $memoContent, axis: .vertical)
                        .font(.system(size: 12, weight: .medium))
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120, alignment: .top) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
                        .background(.black.opacity(0.1)) // 배경색 설정
                        .cornerRadius(10) // 코너 반경 설정
                    
                    HStack {
                        Spacer()
                        Text("\(memoContent.count) / \(maxCharacterLimit)")
                            .font(.system(size: 12))
                            .foregroundColor(memoContent.count == maxCharacterLimit ? .pink : .gray)
                            .padding(.top, -23)
                            .padding(.trailing, 15)
                    }
                    
                }
            }
        }
    }
}

struct MemoAlarmIntervalFormView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("알람 주기 설정")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                Text("푸시 알림으로 반복해서 리마인드할 주기!")
                  .font(.system(size: 12, weight: .medium))
                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            }
            CardContent {
                // 비워두기
                Text("")
                // TODO
            }
        }
    }
}

struct MemoPreView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("미리보기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                Text("다음처럼 보일 예정이에요.")
                  .font(.system(size: 12, weight: .medium))
                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            }
            CardContent {
                // TextEditor의 스크롤 가능한 영역 설정
                Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 0.5)
                .background(.black.opacity(0.2))
            }
        }
    }
}

struct AddMemoFooterView: View {
    var body: some View {
        VStack {
                Text("작성 완료")
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


struct CardContent<Content: View>: View {
    var child: Content
    init(@ViewBuilder content: () -> Content) {
        self.child = content()
    }
    
    var body: some View {
        child
    }
}

struct CardTitleText: View {
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

struct TypeBubble: View {
    var title: String
    var hexCode: String
    
    init(_ title: String, _ hexCode: String){
        self.title = title
        self.hexCode = hexCode
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black.opacity(0.7))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color(hex: hexCode))
            .cornerRadius(15)
    }
}

struct InfoBubble: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.white)
            .padding(6)
            .background(Color.red)
            .clipShape(Circle()) // 원형 모양으로 만듭니다.
    }
}

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: cleanedHex).scanHexInt64(&rgb)

        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct TextFormView: View {
    // Properties
    @State private var text: String = ""
    @State private var placeholder: String = "(예 : 오늘 아침에 일어나서 중랑천 2.5km 뛰었음)"
    private let maxCharacterLimit = 500

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(text.isEmpty ? .white : .black)
                    .onTapGesture {
                        if self.text == placeholder {
                            self.text = ""
                        }
                    }
                    .onChange(of: text) { newValue in
                        if text.count > maxCharacterLimit {
                            text = String(text.prefix(maxCharacterLimit))
                        }
                    }
                    .background(.black.opacity(0.7))
            }
            .frame(height: 120)

            HStack {
                Spacer()
                Text("\(text.count) / \(maxCharacterLimit)")
                    .font(.system(size: 12))
                    .foregroundColor(text.count == maxCharacterLimit ? .pink : .gray)
                    .padding(.trailing, 0)
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
