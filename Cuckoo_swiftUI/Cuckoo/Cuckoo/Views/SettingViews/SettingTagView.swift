import SwiftUI

struct SettingTagView: View {
    @StateObject var viewModel = TagViewModel.shared
    var limit: Int = 3
    var buttonText: String = "새로 추가하기"
    
    @State private var isAddPopoverPresented = false // 태그 추가
    @State private var newTagTitle = ""
    @State private var newTagColor = Color.gray // 새로운 태그 색상
    @State private var emptyTagTitle = false
    
    
    @State private var showAlert = false
    @State private var showEmptyTitleAlert = false//제목 무조건 0자 이상, 제목 중복 없어야 하면 나중에 추가 구현
    @State private var showTagAlert = false//태그 1개 이상 선택 안할시
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "태그 관리")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            ZStack{
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(.defaultPreview)
                            .resizable()
                            .scaledToFill()
                            .frame(width:300, height:300)
                            .cornerRadius(5000)
                            .opacity(0.2)
                        
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    if viewModel.tags.isEmpty {
                        Text("태그를 추가해주세요!")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.cuckooLightGray.opacity(1))
                    }
                    
                    Spacer()
                    
                }.padding(30)
                
                VStack {
                    Spacer()
                    FlowLayout(tags: viewModel.tags)
                        .onAppear{
                            viewModel.browseTags()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
        }.overlay(
            ConfirmFixedButton(
                confirmMessage: buttonText,
                logic: {
                    isAddPopoverPresented.toggle()
                })
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .popover(
                isPresented: $isAddPopoverPresented,
                attachmentAnchor: .rect(.bounds),
                arrowEdge: .bottom) {
                    // 태그 추가 팝업창
                    VStack {
                        Text("새로운 태그 추가")
                            .font(.headline)
                            .padding()
                        
                        TextField("태그 제목", text: $newTagTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        ColorPicker("색상 선택", selection: $newTagColor, supportsOpacity: false)
                            .padding()
                        
                        Button("확인") {
                            // 새로운 태그를 만들어서 tagButtonList에 추가
                            if newTagTitle.isEmpty{
                                emptyTagTitle = true
                            }
                            else{
                                viewModel.addTag(name: newTagTitle, color: newTagColor.hexCode())
                                newTagTitle = "" // 새로운 태그 제목 초기화
                                newTagColor = Color.gray
                                isAddPopoverPresented.toggle()
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal, 30)
                    .alert(isPresented: $emptyTagTitle) {//차후 이미 존재하는 태그들에 대해서 이슈가 있을 수 있음.
                        Alert(
                            title: Text("알림"),
                            message: Text("빈 제목의 태그는 만들 수 없습니다."),
                            dismissButton: .default(Text("확인")){
                                showTagAlert = false
                                showEmptyTitleAlert = false
                            }
                        )
                    }
                }
            
            ,alignment: .bottom
        )
        .navigationBarHidden(true)
    }
    
}

struct AddButton: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        Button(action: {
            //
        }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.gray)
                .font(.system(size: 20))
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(15)
        .opacity(isEnabled ? 1 : 0.2)
    }
}

struct FlowLayout: View {
    var tags: [TagEntity]
    let spacing: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                SettingTagBubble(tag: tag)
                    .padding([.horizontal, .vertical], spacing / 2)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= (lastHeight + spacing)
                        }
                        let result = width
                        if tag == tags.last {
                            width = 0 // reset width
                        } else {
                            width -= (d.width + spacing)
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        lastHeight = d.height
                        return height
                    })
            }
        }
    }
}

struct SettingTagBubble: View {
    @ObservedObject var viewModel = TagViewModel.shared
    @State var isDeleteConfirmationPresented = false
    
    var tag: TagEntity
    
    var body: some View {
        Button {
            isDeleteConfirmationPresented.toggle()
        } label: {
            TagBubbleView(tag: tag)
        }
        .alert(isPresented: $isDeleteConfirmationPresented) {
            Alert(
                title: Text("삭제 확인"),
                message: Text("\(tag.name) 태그를 삭제하시겠습니까?"),
                primaryButton: .destructive(Text("확인")) {
                    viewModel.deleteTag(tagID: tag.objectID)
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
}


struct TagBubbleView: View {
    let tag: TagEntity
    var isSelected: Bool = true

    var body: some View {
        Text(tag.name)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.fromHex(tag.color))
            .cornerRadius(15)
            .foregroundColor(.white)
            .opacity(isSelected ? 1 : 0.4)
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


extension Color {
    
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
    func hexCode() -> String {
            if #available(iOS 14.0, *) {
                guard let components = UIColor(self).resolvedColor(with: UITraitCollection.current).cgColor.components else {
                    return "000000"
                }
                let red = Int(components[0] * 255.0)
                let green = Int(components[1] * 255.0)
                let blue = Int(components[2] * 255.0)
                return String(format: "#%02X%02X%02X", red, green, blue)
            } else {
                // Fallback on earlier versions
                return "000000"
            }
        }
}

extension UIColor {
    static let alertAccentColor = UIColor(named: "#FF4F4F")!
    static let cardBackgroundColor = UIColor(named: "#FAF4E5")!
    static let blockDarkColor = UIColor(named: "#4B4945")!
    static let blockDarkerColor = UIColor(named: "#7d7a73")!
    static let defaultPure = UIColor(named: "#C8C3B7")!
    static let cuckooRed = UIColor(named: "#95281d")!
    static let cuckooPurple = UIColor(named: "#69314c")!
    static let cuckooViolet = UIColor(named: "#492F64")!
    static let cuckooBlue = UIColor(named: "#28456C")!
    static let cuckooGreen = UIColor(named: "#2B593F")!
    static let cuckooYellow = UIColor(named: "#89632A")!
    static let cuckooCarrot = UIColor(named: "#854C1D")!
    static let cuckooBrown = UIColor(named: "#603B2C")!
    static let cuckooDeepGray = UIColor(named: "#5A5A5A")!
    static let cuckooLightGray = UIColor(named: "#D9D9D9")!
    static let backgroundColorCandidate = UIColor(named: "#FFFDF5")!
}
