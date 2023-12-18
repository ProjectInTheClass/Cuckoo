//
//  FirstSharedView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI
import SwiftSoup


struct FirstSharedView: View {
    
    @State private var onClose : () -> Void // 화면 닫는 클로저
    @StateObject private var viewModel = AddMemoViewModel()
    @ObservedObject private var presetViewModel = AlarmPresetViewModel.shared
    @StateObject private var mvm = MemoViewModel.shared
    
    @State var isAddingMemo: Bool = false
    @State var newURL: String = ""
    @State var isSecondViewPresented : Bool = false
    
    // ContentView의 initializer 추가
    init(linkURL: String, onClose: @escaping () -> Void) {
        newURL = linkURL
        self.onClose = onClose
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                Text("메모 등록")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.80))
                Spacer()
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark")
                    
                        .foregroundColor(.black)
                }
            }.frame(height: 60)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            
            //contents
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    
                    //제목
                    MemoTitleFormView(
                        isEditing: $viewModel.isEditing,
                        editedTitle: $viewModel.memoTitle
                    )
                    
                    MemoTypeFormView(
                        selectedTags: $viewModel.tags
                    )
                    .frame(maxWidth: .infinity)
                    
                    //url
                    MemoUrlTypeFormView(link: $newURL)
                        .frame(maxWidth: .infinity)
                    
                    //comment 입력
                    MemoContentFormView(memoContent: $viewModel.memoContent)
                        .frame(maxWidth: .infinity)
                    
                    //alarm period
                    //TODO : 여기서 MemoAlarmPresetFormView
                    MemoAlarmPresetFormView(
                        presetList: $presetViewModel.presets,
                        selectedReminder: $viewModel.selectedReminder,
                        isEditing: $viewModel.isEditing
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .padding(.bottom, 100)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }.alert(isPresented: $isAddingMemo) {
            Alert(
                title: Text("알림"),
                message: Text(viewModel.memoTitle.isEmpty || viewModel.memoContent.isEmpty || viewModel.tags.isEmpty ? "태그와 제목과 내용은 필수입니다." : "메모를 등록하시겠습니까?"),
                primaryButton: .destructive(Text("확인")) {
                    if !(viewModel.memoTitle.isEmpty || viewModel.memoContent.isEmpty || viewModel.tags.isEmpty) {
                        viewModel.link = newURL
                        viewModel.addNewMemo()
                        print(mvm.memos) //memos에 없음...!
                        isSecondViewPresented.toggle()
                        ///여기서 SecondSharedView를 띄운다.
                    }
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }.popover(isPresented: $isSecondViewPresented, arrowEdge: .bottom) {
            // Pass the necessary bindings to the SecondSharedView
            SecondSharedView(onClose : $onClose, newURL: $newURL)
        }

        .overlay(
            AddMemoFooterView(
                addMemoAction: {
                    isAddingMemo.toggle()
                })
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            ,alignment: .bottom)
        .navigationBarBackButtonHidden(true)
    }
    
}
