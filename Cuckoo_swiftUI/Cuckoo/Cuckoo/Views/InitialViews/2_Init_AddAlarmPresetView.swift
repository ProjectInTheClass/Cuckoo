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
    @ObservedObject var alarmPresetViewModel = AlarmPresetViewModel.shared
    
    var body: some View {
        VStack {
            HeaderView(title: "알람 주기를 설정해주세요.")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 30) {
                AddAlarmTermView()
                
                if showAddPresetForm {
                    AddAlarmPresetView()
                }
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            
            
            Spacer()
            
            NavigationLink(
                destination: Init_AddInfoConfirmView(),
                isActive: $navigateToNextScreen
            ) {
                EmptyView()
            }
            
            
            ConfirmFixedButton(confirmMessage: buttonText, logic: {
                
                withAnimation {
                    
                    if !showAddPresetForm {
                        self.showAddPresetForm.toggle()
                        self.buttonText = "알림 정보 등록 완료"
                        self.headerTitle = "프리셋을 추가해주세요!"
                    } else {
                        // 다른 화면으로 이동
                        self.navigateToNextScreen = true
                    }
                }
            })
                .frame(height: 120)
                .frame(maxWidth: .infinity)
            
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
    @State private var selectedReminderPeriod = "1일"
    @State private var isReminderPeriodPopoverPresented = false
    
    @State private var selectedMultiplier = 2
    @State private var isMultiplierPopoverPresented = false
    
    let PeriodOptions = ["1일", "2일", "3일", "4일", "5일", "6일", "1주", "2주", "3주", "4주", "8주"]
    
    var body: some View {
        HStack(alignment: .center) {
            Button("\(selectedReminderPeriod) 주기") {
                // Handle button tap
                isReminderPeriodPopoverPresented.toggle()
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
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
                        ForEach(PeriodOptions, id: \.self) { period in
                            Text("\(period)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                    
                    Button("확인") {
                        isReminderPeriodPopoverPresented.toggle()
                    }
                }
            }
            
            
            Spacer()
            Button("\(selectedMultiplier)배수 증가") {
                // Handle button tap
                isMultiplierPopoverPresented.toggle()
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
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
    
    @ObservedObject var alarmPresetViewModel = AlarmPresetViewModel.shared
    
    @State private var selectedPresets: Set<presetButton> = []
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
    
    var tmp_uuid = "019cc414-42f5-46b8-a245-ed1a19ac9a24"
    
    @State private var isDeleteConfirmationPresented = false
    
    init(){
    }
    
    //불러와서
    func convertToPresetButtons(alarmPresets: [AlarmPreset]) -> [presetButton] {
        return alarmPresets.map { preset in
            return presetButton(emoji: preset.preset_icon, alarmName: preset.preset_name, time: preset.preset_time, preset_id: preset.id)
        }
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
                        // Add "New Alarm Preset"
                        
                        Button {
                            isAddPopoverPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size:30, weight: .regular))
                                .foregroundStyle(.gray)
                        }
                        
                        
                        
                        // Delete "Selected Alarm Preset"
                        
                        Button {
                            if selectedPresets.isEmpty {
                                showAlert(title: "알림", message: "선택된 프리셋이 없습니다.")
                            } else {
                                isDeleteConfirmationPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "trash.circle")
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size:30))
                                .foregroundStyle(selectedPresets.isEmpty ?
                                                 Color(red: 0.7, green: 0.7, blue: 0.7)
                                                 : Color(red: 0, green: 0, blue: 0).opacity(0.80))
                        }
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
                    }.padding(.vertical, 10)
                }
            }
        }
        .onAppear(){
            //불러와서 넣기
            alarmPresetViewModel.browseAlarmPresetFromServer(uuid: "019cc414-42f5-46b8-a245-ed1a19ac9a24") /*Accessing StateObject's object without being installed on a View. This will create a new instance each time.*/
            presetButtonList = convertToPresetButtons(alarmPresets: alarmPresetViewModel.getAlarmPresetList(uuid: tmp_uuid))
            //문제 발생
            presetButtonList.sort { $0.time < $1.time }
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
                    
                    Picker("분", selection: $selectedMinuteIndex) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    
                    Text("분")
                        .font(.headline)
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
    
    func updatePreset(){
        alarmPresetViewModel.browseAlarmPresetFromServer(uuid: tmp_uuid)
        
    }
    
    func editPreset(){
        
    }
    
    func addNewPreset() {
        
        let hour = selectedHourIndex
        let minute = selectedMinuteIndex
        let period = hour < 12 ? "AM" : "PM"
        let formattedTime = String(format: "%02d:%02d %@", hour % 12, minute, period)
        
        // Use the AlarmPresetViewModel to add the new alarm preset
        alarmPresetViewModel.addAlarmPreset(uuid: tmp_uuid, name: newAlarmName, icon: newEmoji, time: formattedTime) { result in
            switch result {
            case .success(let message):
                print(message) // Handle success
                updatePreset()
                presetButtonList = convertToPresetButtons(alarmPresets: alarmPresetViewModel.getAlarmPresetList(uuid: tmp_uuid))
            case .failure(let error):
                showAlert(title: "Error", message: error.localizedDescription) // Handle error
            }
        }
        
        // 시간 순서대로 나오도록
        presetButtonList.sort { $0.time < $1.time }
        
        // 다음을 위해 초기화
        newEmoji = ""
        newAlarmName = ""
        selectedHourIndex = 12
        selectedMinuteIndex = 0
    }
    
    
    
    //    func addNewPreset() {
    //        let hour = selectedHourIndex
    //        let minute = selectedMinuteIndex
    //        let period = hour < 12 ? "AM" : "PM"
    //        let formattedTime = String(format: "%02d:%02d %@", hour % 12, minute, period)
    //
    //        let newPreset = presetButton(emoji: newEmoji, alarmName: newAlarmName, time: formattedTime)
    //        presetButtonList.append(newPreset)
    //
    //        //시간 순대로 나오도록
    //        presetButtonList.sort { $0.time < $1.time }
    //
    //        //다음을 위해 초기화
    //        newEmoji = ""
    //        newAlarmName = ""
    //        selectedHourIndex = 12
    //        selectedMinuteIndex = 0
    //    }
    
    func deleteSelectedPresets() {
        // Create an array to store the successfully deleted preset ids
        var successfullyDeletedIds: [Int] = []
        
        // Use the AlarmPresetViewModel to delete selected alarm presets
        for preset in selectedPresets {
            alarmPresetViewModel.deleteAlarmPreset(uuid: "YOUR_USER_UUID", preset_id: preset.preset_id) { result in
                switch result {
                case .success(let message):
                    print(message) // Handle success
                    successfullyDeletedIds.append(preset.preset_id)
                case .failure(let error):
                    showAlert(title: "Error", message: error.localizedDescription) // Handle error
                }
            }
        }
        
        // Remove only the successfully deleted presets locally
        presetButtonList.removeAll { successfullyDeletedIds.contains($0.preset_id) }
        selectedPresets.removeAll()
    }
    
    
    //    func deleteSelectedPresets() {
    //        presetButtonList.removeAll { selectedPresets.contains($0) }
    //        selectedPresets.removeAll()
    //    }
    
    func showAlert(title: String, message: String) {
        // Show an alert with the given title and message
    }
}
