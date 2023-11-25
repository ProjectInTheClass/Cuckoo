//
//  SettingsView_myAlertPeriod.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct freesetButton{
    var imogi : String
    var alarmName : String
    var time : String
    
    init(imogi: String, alarmName: String, time: String) {
        self.imogi = imogi
        self.alarmName = alarmName
        self.time = time
    }
}

var freesetButton1 = freesetButton(imogi: "🔔", alarmName: "기상", time: "07:00 AM")
var freesetButton2 = freesetButton(imogi: "🔔", alarmName: "점심밥", time: "12:00 PM")
var freesetButton3 = freesetButton(imogi: "🔔", alarmName: "저녁식사", time: "06:00 PM")
var freesetButton4 = freesetButton(imogi: "🔔", alarmName: "운동", time: "05:00 PM")
var freesetButton5 = freesetButton(imogi: "🔔", alarmName: "독서", time: "08:00 PM")
var freesetButton6 = freesetButton(imogi: "🔔", alarmName: "취침 전", time: "10:00 PM")
var freesetButton7 = freesetButton(imogi: "🔔", alarmName: "회의", time: "02:30 PM")
var freesetButton8 = freesetButton(imogi: "🔔", alarmName: "수업 시작", time: "09:00 AM")

var freesetButtonList: [freesetButton] = [freesetButton1, freesetButton2, freesetButton3, freesetButton4, freesetButton5, freesetButton6, freesetButton7, freesetButton8]


struct SettingsView_myAlertPeriod: View {
    
    var freesetButtonList: [freesetButton]
    
    init(freesetButtonList: [freesetButton]) {
        self.freesetButtonList = freesetButtonList
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HeaderView().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Spacer()
                Text("알림 주기/프리셋 설정")
                    .frame(width: 250, height: 29)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }.padding([.top, .bottom], 30)
            
            Section(header: Text("알림 주기 기본값").bold()) {
                VStack(alignment: .leading) {
                    Text("푸시 알림으로 반복해서 리마인드할 주기!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                HStack(alignment: .center) {
                    Spacer()
                    Button("1일 주기") {
                        // Handle button tap
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(.thickMaterial)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    Spacer()
                    Button("2일 주기") {
                        // Handle button tap
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(.thickMaterial)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    Spacer()
                }.padding([.top, .bottom], 20)
            }.padding([.leading, .trailing], 30)
            
            Section(header: Text("알림 프리셋").bold()) {
                VStack(alignment: .leading) {
                    Text("이때 알림을 받고 싶어요")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(freesetButtonList, id: \.alarmName) { button in
                            Button(action: {
                                // Handle button tap
                            }) {
                                HStack {
                                    Text(button.imogi)
                                        .font(.title)
                                    Text(button.alarmName)
                                        .font(.headline)
                                    Spacer()
                                    Text(button.time)
                                        .font(.subheadline)
                                }
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            }
                            .frame(maxHeight: 60)
                            .buttonStyle(NotificationButtonStyle())
        
                        }
                    }
                    .padding([.top, .bottom], 10)
                }
                
//                Spacer()
                
                Button("추가하기") {
                    // Handle button tap
                }
                .font(.headline)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .buttonStyle(NotificationButtonStyle())
            }.padding([.leading, .trailing], 30)
        }
    }
}


// Custom button style for Notification Buttons => 이렇게 따로 만들 수 있다.
struct NotificationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thickMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
        //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            .padding([.top, .horizontal])
    }
}

struct SettingsView_myAlertPeriod_Previews: PreviewProvider {
    static var previews: some View {
        //        SettingsView_myInfo()
        SettingsView_myAlertPeriod(freesetButtonList: freesetButtonList)
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
            Spacer() // Spacer to balance the alignment
        }
    }
}


