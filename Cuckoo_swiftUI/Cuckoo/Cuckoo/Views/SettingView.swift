//
//  SettingView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/23.
//

import SwiftUI

struct SettingView: View {
    @State private var isShowingDetailView = false
    init() {
            // To remove all separators including the actual ones:
            UITableView.appearance().separatorStyle = .none

            // To set the background color of UITableView:
            UITableView.appearance().backgroundColor = .clear // Use .clear to make it transparent
        }
    var body: some View {
        VStack(alignment: .leading) {
            if !isShowingDetailView {
                            SettingHeaderView()
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal,30)
                        }
                NavigationView {
                    
                    
                        // The list now has a clear color and will show the ZStack's background color.
                        List {
                            // User Profile Section
                            Section {
                                NavigationLink(destination: UserProfileView(),isActive: $isShowingDetailView) {
                                    SettingCellView(iconName: "person.crop.circle.fill", title: "경민의 메모장", subtitle: "내 정보 수정하기")
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                            }
                            
                            // Other Settings Sections
                            Section {
                                NavigationLink(destination: SettingTagView(),isActive: $isShowingDetailView) {
                                    Text("태그 관리")
                                }
                                
                                .listRowBackground(Color.gray.opacity(0.2))
                                NavigationLink(destination: AlarmSettingsView(),isActive: $isShowingDetailView) {
                                    Text("알람 주기/프리셋 설정")
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                                NavigationLink(destination: KitSettingsView(),isActive: $isShowingDetailView) {
                                    Text("기타 설정")
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                            }
                            
                            // Logout or Additional Option
                            Section {
                                NavigationLink(destination: LicenseInformationView(),isActive: $isShowingDetailView) {
                                    Text("개인정보 처리 방침")
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                                NavigationLink(destination: LicenseInformationView(),isActive: $isShowingDetailView) {
                                    Text("문의 하기")
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                                
                            }
                            
                        }
                        
                        .listStyle(GroupedListStyle())
                        .background(.white)
                                    .scrollContentBackground(.hidden)
                        
                    }
                    
                    .navigationBarHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                    
                
            
            }
    }
}
struct SettingCellView: View {
    let iconName: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(title)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}
struct SettingHeaderView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    
                    .foregroundColor(.black)
            }
            Spacer()
            Text("설정")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black.opacity(0.80))
            Spacer()
        }
        
    }
    
    
}

// Placeholder Views for the Navigation Destinations
struct UserProfileView: View {
    var body: some View {
        Text("User Profile")
    }
}

struct TagManagementView: View {
    var body: some View {
        Text("Tag Management")
    }
}

struct AlarmSettingsView: View {
    var body: some View {
        Text("Alarm Settings")
    }
}

struct KitSettingsView: View {
    var body: some View {
        Text("Kit Settings")
    }
}

struct LicenseInformationView: View {
    var body: some View {
        Text("License Information")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
