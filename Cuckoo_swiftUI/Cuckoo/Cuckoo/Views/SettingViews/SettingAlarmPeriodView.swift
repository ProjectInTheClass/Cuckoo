//
//  SettingsView_myAlertPeriod.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct SettingsView_myAlertPeriod: View {
    
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
    @State private var selectedPresets: Set<presetButton> = []
    @State private var presetButtonList: [presetButton]
    
    @State private var selectedReminderPeriod = "1일"
    @State private var isReminderPeriodPopoverPresented = false
    
    @State private var isMultiplierPopoverPresented = false
    @State private var selectedMultiplier = 2
    
    @State private var isDeleteConfirmationPresented = false
    
    init(presetButtonList: [presetButton]) {
        _presetButtonList = State(initialValue: presetButtonList)
    }
    
    var body: some View {
        VStack {
            
            HeaderView(title: "알람 주기 / 프리셋 설정")
                .frame(height: 60)
                .frame(maxWidth: .infinity)

            
            Section(header: Text("알림 주기 기본값").bold()) {
                VStack(alignment: .leading) {
                    Text("푸시 알림으로 반복해서 리마인드할 주기!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                HStack(alignment: .center) {
                    Spacer()
                    Button("\(selectedReminderPeriod) 주기") {
                        // Handle button tap
                        isReminderPeriodPopoverPresented.toggle()
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(.thickMaterial)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .popover(isPresented: $isReminderPeriodPopoverPresented) {
                        VStack {
                            Text("알림 주기 선택")
                                .font(.headline)
                                .padding()
                            
                            // Add the Picker code here to select the reminder period
                            Picker("알림 주기", selection: $selectedReminderPeriod) {
                                ForEach(["1일", "2일", "3일", "4일", "5일", "6일", "1주", "2주", "3주", "4주", "8주"], id: \.self) { period in
                                    Text("\(period)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                            
                            Button("확인") {
                                // Handle the selected reminder period
                                // You can update your UI or perform other actions here
                                isReminderPeriodPopoverPresented.toggle()
                            }
                            .padding()
                        }
                    }
                    
                    
                    Spacer()
                    Button("\(selectedMultiplier)배수 증가") {
                        // Handle button tap
                        isMultiplierPopoverPresented.toggle()
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(.thickMaterial)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .popover(isPresented: $isMultiplierPopoverPresented) {
                        VStack {
                            Text("배수 선택")
                                .font(.headline)
                                .padding()
                            
                            // Add the Picker code here to select the multiplier
                            Picker("배수", selection: $selectedMultiplier) {
                                ForEach(1...7, id: \.self) { multiplier in
                                    Text("\(multiplier)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                            
                            Button("확인") {
                                // Handle the selected multiplier
                                // You can update your UI or perform other actions here
                                isMultiplierPopoverPresented.toggle()
                            }
                            .padding()
                        }
                    }
                    
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
                        ForEach(presetButtonList, id: \.alarmName) { button in
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
        
        let newPreset = presetButton(emoji: newEmoji, alarmName: newAlarmName, time: formattedTime)
        presetButtonList.append(newPreset)
        
        //시간 순대로 나오도록
        presetButtonList.sort { $0.time < $1.time }
        
        //다음을 위해 초기화
        newEmoji = ""
        newAlarmName = ""
        selectedHourIndex = 12
        selectedMinuteIndex = 0
    }
    
    func deleteSelectedPresets() {
        presetButtonList.removeAll { selectedPresets.contains($0) }
        selectedPresets.removeAll()
    }
    
    func showAlert(title: String, message: String) {
        // Show an alert with the given title and message
    }
    
}

struct SettingsView_myAlertPeriod_Previews: PreviewProvider {
    static var previews: some View {
        //        SettingsView_myInfo()
        SettingsView_myAlertPeriod(presetButtonList: presetButtonList)
    }
}
