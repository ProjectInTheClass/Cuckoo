//
//  SettingView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/23.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                HeaderView(title: "설정")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                
                HStack {
                    NavigationLink(destination: SettingsProfileView()) {
                        SettingProfileListView(title: "경민의 메모장")
                    }
                }
                
                VStack(spacing: 0) {
                    SettingListView(title: "태그 관리") { SettingTagView() }
                    SettingListView(title: "알람 주기/프리셋 설정") { SettingAlarmPresetView() }
//                    SettingListView(title: "기타 설정") { KitSettingsView() }
                }
                
                VStack(spacing: 0) {
                    
                    SettingListView(title: "개인정보 처리 방침") { LicenseInformationView() }
                    SettingListView(title: "문의 하기") { LicenseInformationView() }
                }
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingProfileListView: View {
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width:45, height:45)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(title)
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



struct KitSettingsView: View {
    var body: some View {
        Text("Kit Settings")
    }
}

struct LicenseInformationView: View {
    var body: some View {
        Text("License Information")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
