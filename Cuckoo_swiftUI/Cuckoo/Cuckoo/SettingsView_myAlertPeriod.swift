//
//  SettingsView_myAlertPeriod.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct SettingsView_myAlertPeriod: View {
    var body: some View {
            VStack {
                HeaderView().padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))

                // 알림 주기 기본값 섹션
                Section(header: Text("알림 주기 기본값").bold(),
                        footer: Text("푸시 알림으로 반복해서 리마인드할 주기!")
                            .font(.footnote)
                            .foregroundColor(.gray)) {
                    HStack {
                        // 버튼 1: 1일 주기
                        Button("1일 주기") {
                            // Handle button tap
                        }
                        .font(.headline)
                        .padding()

                        // 버튼 2: 2일 주기
                        Button("2일 주기") {
                            // Handle button tap
                        }
                        .font(.headline)
                        .padding()
                    }
                }

                // 알림 프리셋 섹션
                Section(header: Text("알림 프리셋").bold(),
                        footer: Text("이때 알림을 받고 싶어요")) {
                    VStack {
                        // 알림 버튼
                        Button(action: {
                            // Handle button tap
                        }) {
                            HStack {
                                // 이모지
                                Text("🔔")
                                    .font(.title)

                                // 알림이름
                                Text("알림 이름")
                                    .font(.headline)

                                // 알림 시간
                                Spacer()
                                Text("12:00 PM")
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                        .buttonStyle(NotificationButtonStyle())

                        Spacer()

                        // 추가하기 버튼
                        Button("추가하기") {
                            // Handle button tap
                        }
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
}

// Custom button style for Notification Buttons
struct NotificationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            .padding([.top, .horizontal])
    }
}

struct SettingsView_myAlertPeriod_Previews: PreviewProvider {
    static var previews: some View {
//        SettingsView_myInfo()
        SettingsView_myAlertPeriod()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            // Navigation back button
            Button(action: {
                // Handle back button action
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
            }
            
            Spacer() // Spacer to push the title to the center
            
            // Title label
            Text("알림 주기/프리셋 설정")
                .frame(width: 250, height: 29)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 66, leading: 0, bottom: 0, trailing: 0))
            
            Spacer() // Spacer to balance the alignment
        }
    }
}
