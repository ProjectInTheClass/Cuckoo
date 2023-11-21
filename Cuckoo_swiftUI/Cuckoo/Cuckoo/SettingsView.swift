//
//  SettingsView.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/19.
//

// SettingsView.swift
// SettingsView.swift
import SwiftUI

struct SettingsView_myInfo: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                
                Button(action: {
                    // Back button action
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
               
                Text("내 정보 수정하기")
                    .frame(width: 150, height: 29)
                    .font(.title)
                    .fontWeight(.bold)
            }
                        
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 140, height: 140)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding(.top, 20) // Adjusted top padding
            
            HStack {
                Text("득수의 메모장")
                    .font(.title2)
                
                Button(action: {
                    // Edit username button action
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 30) {
                RoundedStatsView(title: "보유 메모 수", value: "10")
                RoundedStatsView(title: "누적 알림", value: "999+")
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("등록 태그")
                    .font(.headline)
                
                // Scrollable tag buttons go here
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.vertical, 20)
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

struct SettingsView_myInfo_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView_myInfo()
    }
}
