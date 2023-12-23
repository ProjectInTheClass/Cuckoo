//
//  SettingView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/23.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var userViewModel = UserProfileViewModel.shared
    
    @State var username: String = ""
    
    init() {
        self.username = userViewModel.username
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                HeaderView(title: "설정")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                
                HStack {
                    NavigationLink(destination: SettingsProfileView()) {
                        SettingProfileListView(username: $username)
                    }
                }.onAppear {
                    self.username = userViewModel.getUsername()
                }
                
                VStack(spacing: 0) {
                    SettingListView(title: "태그 관리") { SettingTagView() }
                    SettingListView(title: "알람 주기/프리셋 설정") { SettingAlarmPresetView() }
                    //                    SettingListView(title: "기타 설정") { KitSettingsView() }
                }
                
                VStack(spacing: 0) {
                    
                    SettingListView(title: "개인정보 처리 방침") {
                        LicenseInformationView()
                    }
                    SettingListView(title: "문의 하기") {
                        RequestView()
                    }
                }
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingProfileListView: View {
    @Binding var username: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width:45, height:45)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text("\(username)의 메모장")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.80))
                Text("내 정보 수정하기")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .frame(height: 80)
        .background(.thickMaterial)
    }
}


//
struct SettingListView<T: View>: View {
    var title: String
    var dest: () -> T
    
    init(title: String, @ViewBuilder dest: @escaping () -> T) {
        self.title = title
        self.dest = dest
    }
    
    var body: some View {
        NavigationLink(destination: dest()) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.80))
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .frame(height: 60)
            .background(.thickMaterial)
        }
    }
}

struct LicenseInformationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HeaderView(title: "개인정보 처리 방침")
                .frame(height: 60)
            
            Spacer() // 상단에 공간 추가
            
            HStack{
                Spacer()
                Link(destination: URL(string: "https://quark-hydrant-899.notion.site/82c449c89c7341b683bcedd37b9abab6")!) {
                    HStack {
                        Text("개인정보 처리 방침 이동 link")
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            
            
            Spacer() // 중간에 공간 추가
        }
        .navigationBarHidden(true)
    }
}

struct RequestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HeaderView(title: "문의하기")
                .frame(height: 60)
            
            Spacer() // 상단에 공간 추가
            
            HStack{
                Spacer()
                Link(destination: URL(string: "https://quark-hydrant-899.notion.site/82c449c89c7341b683bcedd37b9abab6")!) {
                    HStack {
                        Text("문의하기 link")
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            
            Spacer() // 중간에 공간 추가
        }
        .navigationBarHidden(true)
    }
}

struct KitSettingsView: View {
    var body: some View {
        Text("Kit Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
