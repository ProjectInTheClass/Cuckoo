//
//  SettingsView_myInfo.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct SettingsProfileView: View {
    
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
    @State private var notificationCount: Int = 999 // Placeholder value
    
    // Tags array fetched from the database (replace this with your actual data)
//    @State private var tags: [String : Int] = ["메모" : 8, "개발관련" : 2, "유튜브" : 1]
    // Alert for confirming tag deletion
    @State private var deleteTagAlert: Alert?
    // ActionSheet for tag options (modify, delete)
    @State private var tagOptionsSheet: ActionSheet?
    @ObservedObject var tagViewModel = TagViewModel.shared
    @ObservedObject var memoViewModel = MemoViewModel.shared
   
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            //최상단 뒤로가기 버튼, 제목
            HeaderView(title:"프로필 설정")
                .frame(height: 60)
            
            //이미지 찾아올 수 있음.
            ImagePicker(isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage)
                .onDisappear {
                    // Handle the selected image here
                    
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
                RoundedStatsView(title: "보유 메모 수", value: memoViewModel.memos.count)
                RoundedStatsView(title: "누적 알림", value: notificationCount)
            }.padding(.bottom, 30)
            
            //디바이더
            Divider()
                .frame(width: UIScreen.main.bounds.width/1.15)
                .padding(.vertical, 20)
            
            TagSectionView(tagViewModel: tagViewModel).padding(.horizontal, 20)
            
            //디바이더
            Divider()
                .frame(width: UIScreen.main.bounds.width/1.15)
                .padding(.vertical, 20)
            
            Spacer()
        }.navigationBarBackButtonHidden(true)
        .padding(.vertical, 20)
    }
    
}

struct RoundedStatsView: View {
    var title: String
    var value: Int
    
    var body: some View {
        VStack {
            
            Text("\(title) :")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text("\(value)개")
                .font(.title)
                .fontWeight(.bold)
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
    @ObservedObject var tagViewModel: TagViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("태그 정보")
                    .font(.headline)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tagViewModel.tags, id: \.self) { tag in
                        TagCountView(tag: tag)
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct SettingsView_myInfo_Tag: View {
    
    let tagName: String
    let numOfMemo : Int
    
    var body: some View {
        HStack{
            Text(tagName + " : " + String(numOfMemo) + " (개)")
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(15)
                .fontWeight(.bold)
        }
        
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


struct SettingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileView()
    }
}
