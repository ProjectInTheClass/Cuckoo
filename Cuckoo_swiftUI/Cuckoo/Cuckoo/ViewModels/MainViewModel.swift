//
//  MainViewModel.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/12/09.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var searchingText : String
    @Published var filteredMemos : [Memo]
    
    
    init(){
        self.searchingText = ""
        self.filteredMemos = items
        
    }
    
    func filterMemos(searchingText: String){
        if searchingText.isEmpty{
            filteredMemos = items
        }else{
            filteredMemos = items.filter { memo in
                memo.title.localizedCaseInsensitiveContains(searchingText) ||
                memo.comment.localizedCaseInsensitiveContains(searchingText) ||
                memo.isPinned == true
            }
        }
    }
    
}
