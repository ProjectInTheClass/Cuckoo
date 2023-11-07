//
//  MainView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

struct MainView: View {
    
    //title 수정용
    @State private var text = "Initial Text"
    @State private var isEditing = false
    
    //메모들을 위한 item
    let items: [Item] = [
        Item(title: "Item 1", details: ["Detail 1", "Detail 2", "Detail 3"], imageName: "arrow.right.circle"),
        Item(title: "Item 2", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 3", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 4", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        Item(title: "Item 5", details: ["Detail A", "Detail B", "Detail C"], imageName: "arrow.right.circle"),
        // Add more items as needed
    ]
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName:"bell")
            }
            //Title
            HStack {
                if isEditing {
                    TextField("Edit text", text: $text)
                        .padding()
                        .border(Color.gray, width: 1)
                        .padding()
                } else {
                    Text(text)
                        .padding()
                        .frame(width: 200)
                }
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                Menu {
                    Button("Cancel", action: {})
                } label: {
                    Image(systemName: "ellipsis")
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
                        Button(action: {
                            // Button action
                        }) {
                            Text("Button \(index + 1)")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
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
    }
}

#Preview {
    MainView()
}
