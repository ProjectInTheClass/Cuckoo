//
//  SettingsView_myAlertPeriod.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct freesetButton : Hashable{// Hash=> 기억해두자
    var emoji : String
    var alarmName : String
    var time : String
    
    init(emoji: String, alarmName: String, time: String) {
        self.emoji = emoji
        self.alarmName = alarmName
        self.time = time
    }
    
    // Implementing the Hashable protocol => 기억해두자
    func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
        hasher.combine(alarmName)
        hasher.combine(time)
    }
}

var freesetButton1 = freesetButton(emoji: "🔔", alarmName: "기상", time: "07:00 AM")
var freesetButton2 = freesetButton(emoji: "🔔", alarmName: "점심밥", time: "12:00 PM")
var freesetButton3 = freesetButton(emoji: "🔔", alarmName: "저녁식사", time: "06:00 PM")
var freesetButton4 = freesetButton(emoji: "🔔", alarmName: "운동", time: "05:00 PM")
var freesetButton5 = freesetButton(emoji: "🔔", alarmName: "독서", time: "08:00 PM")
var freesetButton6 = freesetButton(emoji: "🔔", alarmName: "취침 전", time: "10:00 PM")
var freesetButton7 = freesetButton(emoji: "🔔", alarmName: "회의", time: "02:30 PM")
var freesetButton8 = freesetButton(emoji: "🔔", alarmName: "수업 시작", time: "09:00 AM")

var freesetButtonList: [freesetButton] = [freesetButton1, freesetButton2, freesetButton3, freesetButton4, freesetButton5, freesetButton6, freesetButton7, freesetButton8]

var EmojiList : [String] = ["🍔","🛌","⚽️","📚","🔔", "🌄", "🏙️", "🌆", "🌃"]

struct SettingsView_myAlertPeriod: View {
    
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
    @State private var selectedPresets: Set<freesetButton> = []
    @State private var freesetButtonList: [freesetButton]
    
    @State private var isDeleteConfirmationPresented = false
    
    init(freesetButtonList: [freesetButton]) {
        _freesetButtonList = State(initialValue: freesetButtonList)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HeaderView().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Spacer()
                Text("알림 주기 / 프리셋 설정")
                    .frame(width: 270, height: 30)
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
                                if selectedPresets.contains(button) {
                                    selectedPresets.remove(button)
                                } else {
                                    selectedPresets.insert(button)
                                }
                            }) {
                                HStack {
                                    Text(button.emoji)
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
                            .buttonStyle(NotificationButtonStyle(selected: selectedPresets.contains(button)))
                        }
                    }
                    .padding([.top, .bottom], 10)
                }
                
                HStack {
                    Button("추가하기") {
                        isAddPopoverPresented.toggle()
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    .background(Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                    Button("삭제하기") {
                        if selectedPresets.isEmpty {
                            showAlert(title: "알림", message: "선택된 프리셋이 없습니다.")
                        } else {
                            isDeleteConfirmationPresented.toggle()
                        }
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .alert(isPresented: $isDeleteConfirmationPresented) {
                        Alert(
                            title: Text("삭제 확인"),
                            message: Text("선택된 프리셋을 삭제하시겠습니까?"),
                            primaryButton: .destructive(Text("확인")) {
                                deleteSelectedPresets()
                            },
                            secondaryButton: .cancel(Text("취소"))
                        )
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
        }
        .popover(isPresented: $isAddPopoverPresented) {
            VStack(alignment: .center, spacing: 20) {
                Text("새로운 프리셋 추가")
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Picker("이모지", selection: $newEmoji) {
                    ForEach(EmojiList, id: \.self) { emoji in
                        Text(emoji)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                
                TextField("주기 이름", text: $newAlarmName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                //                TextField("시간", text: $newTime)
                //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                HStack {
                    Picker("시", selection: $selectedHourIndex) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    
                    Text("시")
                        .font(.headline)
//                        .padding(.horizontal)
                    
                    Picker("분", selection: $selectedMinuteIndex) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    
                    Text("분")
                        .font(.headline)
//                        .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    Button("추가") {
                        addNewPreset()
                        isAddPopoverPresented.toggle()
                    }
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 20))
                    .buttonStyle(NotificationButtonStyle(selected: false))
                    
                    Button("취소") {
                        isAddPopoverPresented.toggle()
                        // Reset fields
                        newEmoji = ""
                        newAlarmName = ""
                        newTime = ""
                    }
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 20))
                    .buttonStyle(NotificationButtonStyle(selected: false))
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        }
    }
    
    func addNewPreset() {
            let hour = selectedHourIndex
            let minute = selectedMinuteIndex
            let period = hour < 12 ? "AM" : "PM"
            let formattedTime = String(format: "%02d:%02d %@", hour % 12, minute, period)
            
            let newPreset = freesetButton(emoji: newEmoji, alarmName: newAlarmName, time: formattedTime)
            freesetButtonList.append(newPreset)
            
            //시간 순대로 나오도록
            freesetButtonList.sort { $0.time < $1.time }
            
            //다음을 위해 초기화
            newEmoji = ""
            newAlarmName = ""
            selectedHourIndex = 12
            selectedMinuteIndex = 0
        }
    
    func deleteSelectedPresets() {
        freesetButtonList.removeAll { selectedPresets.contains($0) }
        selectedPresets.removeAll()
    }
    
    func showAlert(title: String, message: String) {
        // Show an alert with the given title and message
    }
    
}
// Custom button style for Notification Buttons => 이렇게 따로 만들 수 있다.
struct NotificationButtonStyle: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(selected ? Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255) : Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255))
            .foregroundColor(selected ? .white : .black)
            .cornerRadius(10)
            .padding([.top, .horizontal])
    }
}

struct SettingsView_myAlertPeriod_Previews: PreviewProvider {
    static var previews: some View {
        //        SettingsView_myInfo()
        SettingsView_myAlertPeriod(freesetButtonList: freesetButtonList)
    }
}



