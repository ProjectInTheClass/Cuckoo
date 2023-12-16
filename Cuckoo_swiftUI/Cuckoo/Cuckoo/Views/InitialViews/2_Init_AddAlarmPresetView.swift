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
    
    @State var term: Int = 1
    @State var multiplier: Int = 1
    
    @ObservedObject var alarmPresetViewModel = AlarmPresetViewModel.shared
    @ObservedObject var userViewModel = UserProfileViewModel.shared
    
    var body: some View {
        VStack {
            HeaderView(title: "알람 주기를 설정해주세요.")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 30) {
                AddAlarmTermView(
                    term: $term, multiplier: $multiplier
                )
                
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
                
                withAnimation(Animation.easeInOut(duration: 0.3)) {
                    
                    if !showAddPresetForm {
                        self.showAddPresetForm.toggle()
                        
                        userViewModel.setTerm(term)
                        userViewModel.setMultiplier(multiplier)
                        
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
    @ObservedObject var userViewModel = UserProfileViewModel.shared
    
    @Binding var selectedReminderPeriod: Int
    @State private var isReminderPeriodPopoverPresented = false
    
    @Binding var selectedMultiplier: Int
    @State private var isMultiplierPopoverPresented = false
    
    let PeriodOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var body: some View {
        HStack(alignment: .center) {
            Button("\(selectedReminderPeriod)일 주기") {
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
                        userViewModel.setTerm(selectedReminderPeriod)
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
                        userViewModel.setMultiplier(selectedMultiplier)
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
    @Binding var term: Int
    @Binding var multiplier: Int
    
    
    var body: some View {
        Section {
            VStack(spacing: 20) {
                AddAlarmTermHeaderView()
                AddAlarmTermBodyView(
                    selectedReminderPeriod: $term,
                    selectedMultiplier: $multiplier
                )
            }
        }
    }
}

struct AddAlarmPresetView: View {
    
    @ObservedObject var viewModel = AlarmPresetViewModel.shared
    
    @State private var selectedPresets: Set<AlarmPresetEntity> = []
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
        
    @State private var isDeleteConfirmationPresented = false
    @State private var emptyNameOrIcon = false
    
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
                                .font(.system(size:30, weight: .light))
                                .foregroundStyle(Color.cuckooDeepGray)
                        }
                        
                        
                        Button {
                            if !selectedPresets.isEmpty {
                                isDeleteConfirmationPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "trash.circle")
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size:30, weight: .light))
                                .foregroundStyle(selectedPresets.isEmpty ?
                                                 Color.cuckooLightGray
                                                 : Color.cuckooDeepGray)
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
                        if viewModel.presets.isEmpty {
                            VStack(alignment: .center) {
                                HStack {
                                    Spacer()
                                    Image(.defaultPreview)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:250, height:250)
                                        .cornerRadius(5000)
                                        .opacity(0.2)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 30)
                                Text("프리셋을 추가해주세요!")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.cuckooLightGray.opacity(1))
                                Spacer()
                                
                            }.padding(30)
                        } else {
                            ForEach(viewModel.presets, id: \.self) { preset in
                                PresetButtonView(
                                    preset:preset,
                                    onToggle: {
                                        if selectedPresets.contains(preset) {
                                            selectedPresets.remove(preset)
                                        } else {
                                            selectedPresets.insert(preset)
                                        }
                                    },
                                    isSelected: selectedPresets.contains(preset)
                                )
                            }
                        }
                    }.padding(.vertical, 10)
                }
            }
        }
        .onAppear{
            viewModel.browsePresets()
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
                        if !newEmoji.isEmpty || !newAlarmName.isEmpty || !newTime.isEmpty {
                            addNewPreset()
                            isAddPopoverPresented.toggle()
                        } else {
                            emptyNameOrIcon.toggle()
                        }
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
            .alert(isPresented: $emptyNameOrIcon) {//차후 이미 존재하는 태그들에 대해서 이슈가 있을 수 있음.
                Alert(
                    title: Text("알림"),
                    message: Text("이름과 이모지 그리고 시간을 정해주세요!"),
                    dismissButton: .default(Text("확인")){
                        emptyNameOrIcon = false
                    }
                )
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        }
    }

    
    func addNewPreset() {
        let hour = selectedHourIndex
        let minute = selectedMinuteIndex
        let formattedTime = String(format: "%02d시 %02d분", hour, minute)
        
        // Use the AlarmPresetViewModel to add the new alarm preset
        viewModel.addAlarmPreset(icon: newEmoji, name: newAlarmName, time: formattedTime)
                
        // 다음을 위해 초기화
        newEmoji = ""
        newAlarmName = ""
        selectedHourIndex = 12
        selectedMinuteIndex = 0
    }
    
    
    func deleteSelectedPresets() {
        for preset in selectedPresets {
            viewModel.deleteAlarmPreset(presetID: preset.objectID)
        }
        
        // Remove only the successfully deleted presets locally
        selectedPresets.removeAll()
    }
    
}


struct PresetButtonView: View {
    var preset: AlarmPresetEntity?
    var onToggle: () -> Void
    var isSelected: Bool
    
    var body: some View {
        Button{
            onToggle()
        } label: {
            if let preset = preset {
                HStack {
                    Text(preset.icon)
                        .font(.title)
                    Text(preset.name)
                        .font(.headline)
                    Spacer()
                    Text(preset.alarm_time)
                        .font(.subheadline)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .frame(maxHeight: 60)
        .buttonStyle(NotificationButtonStyle(selected: isSelected))
    }
}
