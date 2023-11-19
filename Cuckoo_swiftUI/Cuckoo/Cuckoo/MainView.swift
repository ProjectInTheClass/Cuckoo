//
//  MainView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

let paddingView = UIView(frame: CGRect(x:0,y:0, width:30,height:0))

struct MainView: View {
    
    //title 수정용
    @State private var text = "Initial Text"
    @State private var isEditing = false
    @State private var isPresentingMemoSheet = false
    @State private var newMemoTitle = ""
    @State private var newMemoDetails = ""

    
    //메모들을 위한 item
    let items: [Item] = [
        Item(title: "Item 1", details: ["Detail 1", "Detail 2", "Detail 3"], imageName: "arrow.right.circle"),
        Item(title: "Item 2", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 3", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 4", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 5", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        // Add more items as needed
    ]
    
    
    var itemCount: Int {
        return items.count
    }
    
    var body: some View {
        VStack{
            Image(systemName:"bell.circle.fill")
                .resizable()
                .frame(width: 45,height: 45)
                .padding([.leading],300)
                .padding([.top],14)
            //Title
            HStack(spacing:0) {
                if isEditing {
                    TextField("Edit text", text: $text)
                        .border(Color.gray, width: 1)
                        .padding()
                } else {
                    VStack(alignment: .leading,spacing: 0){
                        Text("득수의 메모장")
                            .font(.system(size: 30))
                            .frame(width: 200)
                            .padding([.leading],10)
                        Text("\(itemCount)개의 메모")
                            .frame(width:110)
                            .padding([.leading],10)
                            
                    }
                    
                }
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 30, height: 30)
                        
                }
                Menu {
                    Button("Cancel", action: {})
                    Button("Add Memo", action: {
                        isPresentingMemoSheet.toggle()
                     })
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width:100)
                        .padding([.leading],65)
                        .padding([.trailing],0)
                }
                .sheet(isPresented: $isPresentingMemoSheet) {
                                // Memo entry view
                                AddMemoView()
                            }
            }
            Section{
                List{
                    HStack{
                        TextField("Search",text:$text)
                        
                        Image(systemName: "magnifyingglass")
                    }
                }
                .frame(height:100)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<10) { index in
                        CardContent {
                            HStack {
                                TypeBubble("메모", "#b2b2b2")
                                TypeBubble("기록", "#b2b2b2")
                            }
                        }
                    }
                }
                .padding()
            }
            ScrollView{
                ForEach(items, id: \.title) { item in
                    MainContainerView(title: item.title, details: item.details, imageName: item.imageName)
                        .padding(.bottom, 16)
                }
            }
        }
        .tabItem {
            Image(systemName: "1.circle")
            Text("Main")
        }
    }
}

struct MainView_PreViews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
