//
//  2_Init_AddAlarmPresetView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/26.
//

import SwiftUI
import Combine


struct Init_AddAlarmPresetView: View {
    
    
    @State private var showAddPresetForm = false
    @State private var buttonText = "알림주기 등록 완료"
    @State private var headerTitle = "알림 주기를 설정해주세요!"
    @State private var navigateToNextScreen = false

    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "알람 주기를 설정해주세요.")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 30) {
                    AddAlarmTermView()
                            
                    if showAddPresetForm {
                        AddAlarmPresetView(presetButtonList: presetButtonList)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity)
                
                
                Spacer()
                
                NavigationLink(destination: Init_AddInfoConfirmView(), isActive: $navigateToNextScreen) {
                    EmptyView()
                }
                
                
                ConfirmFixedButton(confirmMessage: buttonText)
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        if !showAddPresetForm {
                            self.showAddPresetForm.toggle()
                            self.buttonText = "알림 정보 등록 완료"
                            self.headerTitle = "프리셋을 추가해주세요!"
                        } else {
                            // 다른 화면으로 이동
                            self.navigateToNextScreen = true
                        }
                    }
                
            }.navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
        
    }
}




struct Init_AddAlarmPresetView_Previews: PreviewProvider {
    static var previews: some View {
        Init_AddAlarmPresetView()
    }
}


// Component
struct AddAlarmTermHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("알람 주기 기본값")
                    .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                
                Spacer()
            }
            Text("푸시 알림으로 반복해서 리마인드할 주기!")
              .font(.system(size: 12, weight: .medium))
              .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
        }
    }
}

struct AddAlarmTermBodyView: View {
    var body: some View {
        HStack(alignment: .center) {
//                        Spacer()
            Button("1일 주기") {
                // Handle button tap
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
            .background(.thickMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
            
            Spacer()
            Button("2배수 증가") {
                // Handle button tap
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
            .background(.thickMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct AddAlarmTermView: View {
    var body: some View {
        Section {
            VStack(spacing: 20) {
                AddAlarmTermHeaderView()
                AddAlarmTermBodyView()
            }
        }
    }
}

struct AddAlarmPresetView: View {
    
    @State private var selectedPresets: Set<presetButton> = []
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
    @State private var presetButtonList: [presetButton]
    
    
    @State private var isDeleteConfirmationPresented = false
    
    init(presetButtonList: [presetButton]) {
        _presetButtonList = State(initialValue: presetButtonList)
    }
    
    var body: some View {
        Section {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("알람 프리셋")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                        
                        Spacer()
                    }
                    Text("이때 알림을 받고싶어요")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .overlay(
                    HStack(spacing: 10) {
                        // TODO : Handling click event
                        Image(systemName: "plus.circle")
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size:30, weight: .regular))
                            .foregroundStyle(.gray)
                        
                        Image(systemName: "trash.circle")
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size:30))
                            .foregroundStyle(selectedPresets.isEmpty ?
                                             Color(red: 0.7, green: 0.7, blue: 0.7)
                                           : Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    },
                    alignment: .trailing
                )
                
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
//                            Divider()
                        }
                    }
                }
            }
        }.popover(isPresented: $isAddPopoverPresented) {
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
