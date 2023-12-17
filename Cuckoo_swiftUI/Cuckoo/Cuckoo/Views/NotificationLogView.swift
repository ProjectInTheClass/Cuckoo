//
//  NotificationLogView.swift
//  Cuckoo
//
//  Created by DKSU on 12/6/23.
//

import SwiftUI

struct NotificationLogView: View {
    @StateObject var viewModel = NotificationLogViewModel.shared
    
    
    
    var body: some View {
        VStack {
            HeaderView(title: "알림")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .overlay(
                    Button{
                        viewModel.addLog(related_preset: AlarmPresetViewModel.shared.presets[0], memos: MemoViewModel.shared.memos)
                    }label: {
                        // Add logic
                        Text("더미 메모 추가(Test)")
                    }
                    
                    , alignment: .top)
            
            Spacer()
            
            if viewModel.logs.isEmpty {
                
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(viewModel.logs, id: \.self) { log in
                            LogCardView(
                                log: log,
                                memos: viewModel.getMemosOnLog(logID: log.objectID),
                                alarm_time: viewModel.getLogPreset(logID: log.objectID)?.name,
                                count: viewModel.getMemoCountOnLog(logID: log.objectID)
                            )
                        }
                    }.padding(.top, 30)
                }
            }
            
            
        }.navigationBarBackButtonHidden(true)
    }    
}

struct NotificationLogView_preview: PreviewProvider {
    static var previews: some View {
        NotificationLogView()
    }
}

struct LogCardView: View {
    var log: NotiLogEntity
    var memos: [MemoEntity]?
    var alarm_time: String?
    var count: Int
    
    @State var isOpened: Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("알림")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                        
                        Text("\"\(alarm_time ?? "한번")\"에 \(count)개 알림 전달됨!")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.black)
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text(getTimeDelta(targetTime: log.sent_at ?? Date()))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.black.opacity(0.5))
                    
                    Button {
                        withAnimation(Animation.easeInOut(duration: 0.3)) {
                            isOpened.toggle()
                        }
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
            
            if isOpened {
                if let memos = memos {
                    ForEach(memos, id: \.self) { memo in
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
                                    noti_preset: memo.memo_preset,
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
                    .padding(.horizontal, 30)
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    func getTimeDelta(targetTime: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: targetTime, to: now)

        if let year = components.year, year > 0 {
            return "\(year)년 전"
        } else if let month = components.month, month > 0 {
            return "\(month)달 전"
        } else if let day = components.day, day > 0 {
            return "\(day)일 전"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)시간 전"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)분 전"
        } else {
            return "방금 전"
        }
    }
}
