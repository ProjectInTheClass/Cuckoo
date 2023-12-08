//
//  NotificationLogView.swift
//  Cuckoo
//
//  Created by DKSU on 12/6/23.
//

import SwiftUI

struct NotificationLogView: View {
    
    let dummy_logs: [NotificationLog] = [
        NotificationLog(
            id: 1,
            userId: 1,
            memoIdList: [1,2,3],
            sentAt: "2시간 전",
            sentTerm: "아침 시간대"
        ),
        NotificationLog(
            id: 2,
            userId: 1,
            memoIdList: [2,3],
            sentAt: "11시간 전",
            sentTerm: "저녁 시간대"
        ),
        NotificationLog(
            id: 3,
            userId: 1,
            memoIdList: [1,2,3],
            sentAt: "하루 전", 
            sentTerm: "아침 시간대"
        )
    ]
    
    
    var body: some View {
        VStack {
            HeaderView(title: "알림")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(dummy_logs, id: \.id) { logs in
                        HStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("알림")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    Text("\"\(logs.sentTerm)\"에 \(logs.memoIdList.count)개 알림 전달됨!")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(Color.black)
                                }
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(logs.sentAt)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Button {
                                    // TODO : 아래 서랍 열리고(서랍 Item 정의 필요), 부드럽게 Scroll & Animation
                                } label: {
                                    Image(systemName:"chevron.down")
                                        .resizable()
                                        .frame(width: 20, height: 11, alignment: .trailing)
                                        .foregroundColor(Color.cuckooDeepGray)
                                }
                                    
                            }
                        }
                        .frame(height: 90)
                        .padding(.horizontal, 30)
                        .background(Color.cardBackground)
                    }
                }.padding(.top, 30)
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct NotificationLogView_preview: PreviewProvider {
    static var previews: some View {
        NotificationLogView()
    }
}
