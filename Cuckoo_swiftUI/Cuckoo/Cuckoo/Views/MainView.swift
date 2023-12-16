//
//  MainView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var memoViewModel = MemoViewModel.shared
    @ObservedObject var tagViewModel = TagViewModel.shared
    let context = CoreDataManager.shared.persistentContainer.viewContext
    


    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // Header
                MainViewHeader(itemCount: memoViewModel.memos.count)
                Spacer()

                // Search Bar & Tag
                // TODO:: Tag에 의한 filtering먼저 적용 -> 이후 남아있는 memo들에 대해 키워드를 포함하는 memo만 보이게끔
                // 검색어가 없다면 전부를 보여주게끔 해야함.
                MainViewSearchFilter(
                    searchKeyword: $memoViewModel.searchKeyword,
                    selectedTags: $memoViewModel.selectedTags,
                    tags: tagViewModel.tags, // Assuming you have a way to get the list of tags
                    onFilterChange: { newKeyword, newSelectedTags in
                        memoViewModel.updateFilterCriteria(selectedTags: newSelectedTags, searchKeyword: newKeyword)
                    }
                )
                
                // Body
                ZStack {
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Image(.defaultPreview)
                                .resizable()
                                .scaledToFill()
                                .frame(width:300, height:300)
                                .cornerRadius(5000)
                                .opacity(0.10)
                            
                            Spacer()
                        }
                        .padding(.bottom, 30)
                        if memoViewModel.memos.isEmpty {
                            Text("메모를 추가해주세요!")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.cuckooLightGray.opacity(0.75))
                        }
                        
                        Spacer()
                        
                    }.padding(30)
                    
                    
                    ScrollView {
                        // TODO :: 선택된 Tag들 중 하나라도 해당되는 Memo만 View하도록 Filtering
                        // Filtering 된 Memo만 볼 수 있게끔 해야함
                        ForEach(memoViewModel.filteredMemos, id: \.self) { memo in
                            VStack(alignment: .leading) {
                                NavigationLink(
                                    destination: MemoDetailView(
                                        viewModel: MemoDetailViewModel(
                                            memoID: memo.objectID,
                                            memo: memo
                                        ),
                                        title: memo.title,
                                        comment: memo.comment,
                                        url: memo.url,
                                        thumbURL: memo.thumbURL,
                                        noti_cycle: memo.noti_cycle,
                                        noti_preset: memo.noti_preset,
                                        noti_count: memo.noti_count
                                    )
                                ) {
                                    
                                    MainContainerView(
                                        memo: memo,
                                        title: memo.title,
                                        comment: memo.comment,
                                        url: memo.url,
                                        thumbURL: memo.thumbURL,
                                        isPinned: memo.isPinned,
                                        created_at: memo.created_at
                                    )
                                }.padding(.vertical, 15)
                                
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .onAppear {
                        memoViewModel.browseMemos() // Refresh memos list when MainView appears
                    }
                    .scrollIndicators(.hidden)
                    
                    
                } // ZStack
            }
            .padding(.horizontal, 30)
            .overlay(
                AddMemoFloatingButton(),
                alignment: .bottomTrailing
            )
        }
    }
}


struct MainView_PreViews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// Components

struct MainViewHeader: View {
    var itemCount: Int
    
    @State private var text = "Initial Text"
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination:SettingView()){
                    Image(systemName:"gearshape.circle.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .foregroundColor(Color.cuckooNormalGray)
                        .padding(.trailing, 10)
                }
                NavigationLink(destination: NotificationLogView()){
                    Image(systemName:"bell.circle.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .foregroundColor(Color.cuckooNormalGray)
                }
            }
            Spacer()
        }.frame(height: 80)
        

        //Title
        VStack{
            HStack(spacing:0) {
                if isEditing {
                    TextField("Edit text", text: $text)
                        .border(Color.gray, width: 1)
                        .padding()
                } else {
                    VStack(alignment: .leading,spacing: 0){
                        Text("득수의 메모장")
                            .font(.system(size: 30, weight: .heavy))
                            .lineSpacing(130)
                            .kerning(-0.03)
                            .multilineTextAlignment(.leading)
                        Text("\(itemCount)개의 메모")
                            .font(.system(size:12, weight: .regular))
                            .lineSpacing(52)
                            .kerning(0)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    }
                    
                }
                Spacer()
            }
        }
    }
}

struct MainViewSearchFilter: View {
    @ObservedObject var memoViewModel = MemoViewModel.shared
    @Binding var searchKeyword: String
    @Binding var selectedTags: Set<TagEntity>
    @State var isInit: Bool = true
    
    var tags: [TagEntity]
    var onFilterChange: (String, Set<TagEntity>) -> Void
    
    
    var body: some View {
        // TextEditor의 스크롤 가능한 영역 설정
        VStack(spacing: 18) {
            HStack(spacing: 0){
                TextField("검색어를 입력해주세요!", text: $searchKeyword)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.leading, 25)
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 36, alignment: .top)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.defaultPure, lineWidth: 1)).opacity(0.5)
            }
            .onAppear (perform : UIApplication.shared.hideKeyboard)
            .overlay(Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
                .foregroundColor(.gray)
                     , alignment: .leading)
        
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        TagBubbleView(tag: tag, isSelected: isSelected(tag: tag))
                            .onTapGesture {
                                withAnimation(Animation.easeInOut(duration: 0.3)) {
                                    toggleTagSelection(tag: tag)
                                    memoViewModel.browseMemos()
                                }
                            }
                    }
                }
            }
        }.onAppear {
            if isInit {
                isInit = false
                for tag in tags {
                    selectedTags.insert(tag)
                }
            }
        }
        
    }
    
    
    private func isSelected(tag: TagEntity) -> Bool {
        return selectedTags.contains(tag)
    }
    private func toggleTagSelection(tag: TagEntity) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    private func applyFilters() {
        onFilterChange(searchKeyword, selectedTags)
    }
}

struct AddMemoFloatingButton: View {
    var body: some View {
        // Floating Action Button
        NavigationLink(destination:AddMemoView()){
            Image(systemName: "pencil")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.cuckooNormalGray)
        .clipShape(Circle())
        .padding(.trailing, 60)
        .padding(.bottom, 16) // Adjust the bottom padding as needed
        
    }
}
