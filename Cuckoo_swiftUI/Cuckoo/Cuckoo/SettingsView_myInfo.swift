//
//  SettingsView_myInfo.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct SettingsView_myInfo: View {
    
    //프로필 사진 용
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: Image?
    
    //프로필 유저 이름용
    @State private var username: String = "득수"
    
    // Temporary variable to store the new username
    @State private var editedUsername = ""
    
    // Flag to control the display of the username editing pop-up
    @State private var isEditUsernamePopoverPresented = false
    
    //보유 메모수, 누적 알림
    @State private var memoCount: String = "10" // Placeholder value
    @State private var notificationCount: String = "999+" // Placeholder value
    
    // Tags array fetched from the database (replace this with your actual data)
    @State private var tags: [String] = ["Tag1", "Tag2", "Tag3"]
    // Alert for confirming tag deletion
    @State private var deleteTagAlert: Alert?
    // ActionSheet for tag options (modify, delete)
    @State private var tagOptionsSheet: ActionSheet?
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            HeaderView().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            //최상단 뒤로가기 버튼, 제목
            HStack {
                
                Text("내 정보 수정하기")
                    .frame(width: 200, height: 29)
                    .font(.title)
                    .fontWeight(.bold)
            }.padding(.vertical, 20)
            
            //이미지 찾아올 수 있음.
            ImagePicker(isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage)
                .onDisappear {
                    // Handle the selected image here
                    // For example, you can save it to your model or upload it to a server
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(selectedImage: $selectedImage)
                }
                .padding(.vertical, 20)
            
            //프로필(이름) 편집
            HStack {
                Text("\(username)의 메모장")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Button(action: {
                    isEditUsernamePopoverPresented.toggle()
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                }.popover(isPresented: $isEditUsernamePopoverPresented, arrowEdge: .bottom) {
                    // Popover content for editing the username
                    VStack {
                        Text("사용자 이름 수정")
                        TextField("미입력시 수정 사항 없음.", text: $editedUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 200)
                            .padding()
                            
                        
                        HStack {
                            Button("취소") {
                                // Handle cancellation
                                isEditUsernamePopoverPresented.toggle()
                            }
                            .padding()
                            
//                            Spacer()
                            
                            Button("확인") {
                                // Handle username confirmation
                                if !editedUsername.isEmpty {
                                    username = editedUsername
                                }
                                isEditUsernamePopoverPresented.toggle()
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }.padding()
            
            //수치 정보 창
            HStack(spacing: 30) {
                RoundedStatsView(title: "보유 메모 수", value: memoCount)
                RoundedStatsView(title: "누적 알림", value: notificationCount)
            }.padding(.bottom, 30)
            
            //디바이더
            Divider()
                .frame(width: UIScreen.main.bounds.width/1.15)
                .padding(.vertical, 20)
            
            TagSectionView(
                tags: $tags,
                deleteTagAlert: $deleteTagAlert,
                tagOptionsSheet: $tagOptionsSheet,
                onDeleteTag: { tag in
                    // Handle tag deletion
                    showDeleteTagAlert(tag: tag)
                },
                onModifyTag: { tag in
                    // Handle tag modification
                    showTagOptions(tag: tag)
                }
            ).padding(.horizontal, 20)
            
            //디바이더
            Divider()
                .frame(width: UIScreen.main.bounds.width/1.15)
                .padding(.vertical, 20)
            
            Spacer()
        }
        .padding(.vertical, 20)
    }
    
    //태그 관리용 함수
    // Function to show an alert for confirming tag deletion
    private func showDeleteTagAlert(tag: String) {
        deleteTagAlert = Alert(
            title: Text("Delete Tag"),
            message: Text("Are you sure you want to delete the tag '\(tag)'?"),
            primaryButton: .default(Text("Cancel")),
            secondaryButton: .destructive(Text("Delete"), action: {
                // Handle tag deletion here (remove from the tags array or your data source)
                tags.removeAll { $0 == tag }
            })
        )
    }
    
    // Function to show an action sheet for tag options (modify, delete)
    private func showTagOptions(tag: String) {
        tagOptionsSheet = ActionSheet(
            title: Text("Tag Options"),
            buttons: [
                .default(Text("Modify"), action: {
                    // Handle tag modification here (show another alert for editing the tag name)
                    showModifyTagAlert(tag: tag)
                }),
                .destructive(Text("Delete"), action: {
                    // Show alert for confirming tag deletion
                    showDeleteTagAlert(tag: tag)
                }),
                .cancel()
            ]
        )
    }
    
    // Function to show an alert for modifying the tag name
    private func showModifyTagAlert(tag: String) {
        // You can use a TextField in the alert to let the user input a new tag name
        // Handle the modification based on user input
    }
}

struct RoundedStatsView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(20)
        .frame(width: 130, height: 130)
        .background(Color.blue)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
    }
}

struct TagSectionView: View {
    @Binding var tags: [String]
    @Binding var deleteTagAlert: Alert?
    @Binding var tagOptionsSheet: ActionSheet?
    var onDeleteTag: (String) -> Void
    var onModifyTag: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("등록 태그")
                    .font(.headline)
                
                Spacer()
                
                // Add Tag Button
                Button(action: {
                    // Handle adding a new tag
                }) {
                    Text("태그 추가")
                        .foregroundColor(.blue)
                }
            }
            
            // List of Tags => 아직 데이터 형식을 몰라서 일단
            //            List {
            //                ForEach(tags, id: \.self) { tag in
            //                    HStack {
            //                        Text(tag)
            //
            //                        Spacer()
            //
            //                        // Buttons for each tag
            //                        Button(action: {
            //                            // Handle tag options (modify, delete)
            //                            onModifyTag(tag)
            //                        }) {
            //                            Image(systemName: "ellipsis.circle")
            //                                .foregroundColor(.gray)
            //                        }
            //                        .actionSheet(tagOptionsSheet ?? ActionSheet(title: Text(""), buttons: []))
            //
            //                        Button(action: {
            //                            // Handle tag deletion
            //                            onDeleteTag(tag)
            //                        }) {
            //                            Image(systemName: "trash.circle")
            //                                .foregroundColor(.red)
            //                        }
            //                        .alert(deleteTagAlert ?? Alert(title: Text(""), message: Text(""), dismissButton: .default(Text(""))))
            //                    }
            //                }
            //            }
            //            .listStyle(PlainListStyle())
        }
        .padding(.horizontal, 20)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: Image?
        
        init(selectedImage: Binding<Image?>) {
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = Image(uiImage: uiImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ImagePicker: View {
    @Binding var isImagePickerPresented: Bool
    @Binding var selectedImage: Image?
    
    var body: some View {
        Button(action: {
            isImagePickerPresented.toggle()
        }) {
            ZStack {
                if selectedImage != nil {
                    selectedImage!
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }
            }
        }
    }
}


struct SettingsView_myInfo_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView_myInfo()
        //        SettingsView_myAlertPeriod()
    }
}
