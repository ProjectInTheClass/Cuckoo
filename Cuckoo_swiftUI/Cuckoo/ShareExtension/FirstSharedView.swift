import Foundation
import SwiftUI
import SwiftSoup
import CoreData

struct FirstSharedView: View {
    @State var onClose : () -> Void
    @State var onOpenInApp : (URL) -> Void
    @StateObject private var viewModel = AddMemoViewModel()
    @ObservedObject private var presetViewModel = AlarmPresetViewModel.shared

    @State var isAddingMemo: Bool = false
    @State var newURL: String = ""
    @State var isSecondViewPresented : Bool = false
    @State var newMemo: MemoEntity?

    // ContentView의 initializer 추가
    init(linkURL: String, onClose: @escaping () -> Void, onOpenInApp : @escaping (URL) -> Void) {
        newURL = linkURL
        self.onClose = onClose
        self.onOpenInApp = onOpenInApp
        self.newMemo = nil
        
        print("init")
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
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))

            // Contents
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    // Title
                    MemoTitleFormView(
                        isEditing: $viewModel.isEditing,
                        editedTitle: $viewModel.memoTitle
                    )
                    
                    // Type
                    MemoTypeFormView(
                        selectedTags: $viewModel.tags
                    )
                    .frame(maxWidth: .infinity)
                    
                    // URL
                    MemoUrlTypeFormView(link: $newURL)
                        .frame(maxWidth: .infinity)
                    
                    // Comment input
                    MemoContentFormView(memoContent: $viewModel.memoContent)
                        .frame(maxWidth: .infinity)
                    
                    // Alarm period (using MemoAlarmPresetFormView)
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
        }
        .alert(isPresented: $isAddingMemo) {
            Alert(
                title: Text("알림"),
                message: Text(viewModel.memoTitle.isEmpty || viewModel.memoContent.isEmpty || viewModel.tags.isEmpty ? "태그와 제목과 내용은 필수입니다." : "메모를 등록하시겠습니까?"),
                primaryButton: .destructive(Text("확인")) {
                    if !(viewModel.memoTitle.isEmpty || viewModel.memoContent.isEmpty || viewModel.tags.isEmpty) {
                        viewModel.link = newURL
                        viewModel.addNewMemo { newMemoResult in
                            if let newMemoResult = newMemoResult {
                                self.newMemo = newMemoResult
                                isSecondViewPresented.toggle()
                            }
                        }
                    }
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .popover(isPresented: $isSecondViewPresented, arrowEdge: .bottom) {
            SecondSharedView(onClose: $onClose, onOpenInApp: $onOpenInApp, newMemo: $newMemo)
                .frame(height: 500) // Set specific height for popover
                .environment(\.colorScheme, .light)
        }
        .overlay(
            AddMemoFooterView(addMemoAction: { isAddingMemo.toggle() })
                .frame(height: 60)
                .frame(maxWidth: .infinity),
            alignment: .bottom
        )
        .navigationBarBackButtonHidden(true)
    }
}
