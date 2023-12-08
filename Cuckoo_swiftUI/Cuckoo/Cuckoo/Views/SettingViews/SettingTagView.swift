import SwiftUI

struct SettingTagView: View {
    @StateObject var viewModel = SettingTagViewModel()
    @State private var isShowingDetailView = false

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "태그 관리")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.tags) { tag in
                        SetTagView(tag: tag)
                    }
                    addButton()
                }
            }
            .frame(height: 40)
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    func addButton() -> some View {
        Button(action: {
            viewModel.addTag(name: "새 태그", color: "#FFFFFF") // Example call
        }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.gray)
                .font(.system(size: 20))
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(15)
    }
}

struct SetTagView: View {
    let tag: Tag

    var body: some View {
        Text(tag.name)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.fromHex(tag.color))
            .cornerRadius(15)
            .foregroundColor(.white)
    }
}

struct SettingTagHeaderView: View {
    var body: some View {
        HStack {
            Button(action: {
                // Action to go back
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            Spacer()
            Text("태그 관리")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black.opacity(0.80))
            Spacer()
        }
    }
}

struct SettingTagView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTagView()
    }
}
