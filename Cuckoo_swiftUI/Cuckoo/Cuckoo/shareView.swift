import SwiftUI
////
//////ShareViewController 수정
////class ShareViewController: UIViewController {
////    @IBOutlet var container: UIView!
////
////    // in ShareViewController
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // this gets the incoming information from the share sheet
////        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
////            if let attachments = item.attachments {
////                for attachment: NSItemProvider in attachments {
////                    if attachment.hasItemConformingToTypeIdentifier("public.text") {
////                        attachment.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: { text, _ in
////
////                            // text variable is the text from the share sheet...
////                            // this will add your SwiftUI View to the UIViewController
////                            //let childView = UIHostingController(rootView: AirlistShareView(name: text as! String, note: ""))
////                            //self.addChild(childView)
////                            //childView.view.frame = self.container.bounds
////                            //self.container.addSubview(childView.view)
////                            //childView.didMove(toParent: self)
////                            // text variable is the text from the share sheet...
////                            let childView = UIHostingController(rootView: SwiftUIView())
////                            self.addChild(childView)
////                            childView.view.frame = self.container.bounds
////                            self.container.addSubview(childView.view)
////                            childView.didMove(toParent: self)
////                        })
////                    }
////                }
////            }
////        }
////        
////        // at the end of viewDidLoad
////        NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
////            self.close()
////        }
////
////    }
////
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////    }
////    
////    // add this function to UIShareViewController
////    func close() {
////        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
////    }
////    
////}
//
//class Memo {
//    var type: String? = ""
//    var title: String = ""
//    var content: String = ""
//    var notification: String?
//    var tags: [String] = []
//    
////    init(){
////        type = ""
////        title = ""
////        content = ""
////        notification = ""
////        tags = []
////    }
//}
//
////struct SwiftUIView: View {
////    // Memo 객체 생성
////    @State private var memo = Memo()
////
////    var body: some View {
////        ZStack(alignment: .bottom) {
////            // Background content (could be a background color or an image)
////            Color.white
////            
////            VStack {
////                Text("메모 등록")
////                    .font(.title)
////                    .padding()
////
////                // 각 섹션에 대한 뷰 추가
////                MemoTypeSectionView(selectedType: $memo.type, tags: $memo.tags)
////                MemoTitleSectionView(title: $memo.title)
////                MemoContentSectionView(content: $memo.content)
////
////                // 왼쪽 버튼은 팝업 표시, 오른쪽 버튼은 두 번째 화면으로 이동
////                HStack {
////                    NotificationPeriodSectionView(notification: $memo.notification)
////                    NavigationLink(destination: SecondScreen(memo: memo)) {
////                        Text("등록 완료")
////                            .foregroundColor(.white)
////                            .padding()
////                            .background(Color.purple)
////                            .cornerRadius(10)
////                    }
////                }
////                .padding()
////            }
////            .padding()
////            .frame(height: 500) // Fixed height of 500 points
////        }
////    }
////}
//
class ShareViewController: UIViewController {
    @IBOutlet var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.text") {
                        attachment.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: { text, _ in
                            let childView = UIHostingController(rootView: SwiftUIView())
                            self.addChild(childView)
                            childView.view.frame = self.container.bounds
                            self.container.addSubview(childView.view)
                            childView.didMove(toParent: self)
                        })
                    }
                }
            }
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
            self.close()
        }
    }

    func close() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}

class Memo {
    var type: String? = ""
    var title: String = ""
    var content: String = ""
    var notification: String?
    var tags: [String] = []
}

struct SwiftUIView: View {
    @State private var memo = Memo()
    
    var body: some View {
        NavigationView { // Embed in NavigationView
            ZStack(alignment: .bottom) {
                Color.white
                
                VStack {
                    
                    Text("메모 등록")
                        .font(.title)
                        .padding()
                

                    MemoTypeSectionView(selectedType: $memo.type, tags: $memo.tags)
                    MemoTitleSectionView(title: $memo.title)
                    MemoContentSectionView(content: $memo.content)

                    HStack {
                        NotificationPeriodSectionView(notification: $memo.notification)
                        NavigationLink(destination: SecondScreen(memo: memo)) {
                            Text("등록 완료")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .padding()
                .frame(height: 500)
            }
            .navigationBarTitle("") // Empty title to hide the default navigation bar title
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

struct MemoTypeSectionView: View {
    @Binding var selectedType: String?
    @Binding var tags: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("메모 타입").font(.headline).padding(.bottom, 5)
            
            // 여러 개의 태그를 표시하고, + 버튼을 누르면 새로운 태그 추가
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag).padding(5).background(Color.blue).foregroundColor(.white).cornerRadius(5)
                }
                Spacer()
                Button(action: {
                    // + 버튼을 누르면 새로운 태그 추가
                    // 여기에 새로운 태그를 추가하는 코드를 작성
                }) {
                    Text("+").padding(5).background(Color.green).foregroundColor(.white).cornerRadius(5)
                }
            }
            
            // 기존의 메모 타입을 선택하거나 새로운 메모 타입을 추가
            Picker("메모 타입", selection: $selectedType) {
                Text("기록").tag("기록")
                Text("게임 관련").tag("게임 관련")
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

struct MemoTitleSectionView: View {
    @Binding var title: String//?

    var body: some View {
        VStack(alignment: .leading) {
            Text("메모 제목").font(.headline).padding(.bottom, 5)
            
            // 메모 제목을 입력할 수 있는 텍스트 필드
            TextField("메모 제목을 입력하세요", text: $title)//Cannot convert value of type 'Binding<String?>' to expected argument type 'Binding<String>'
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
        }
        .padding()
    }
}

struct MemoContentSectionView: View {
    @Binding var content: String//?

    var body: some View {
        VStack(alignment: .leading) {
            Text("메모 내용").font(.headline).padding(.bottom, 5)
            
            // 메모 내용을 입력할 수 있는 텍스트 필드 (최대 500자)
            TextEditor(text: $content)//Cannot convert value of type 'Binding<String?>' to expected argument type 'Binding<String>'
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .frame(height: 100)
        }
        .padding()
    }
}

struct NotificationPeriodSectionView: View {
    @Binding var notification: String?
    
    // 옵션 목록
    let options = ["Option 1", "Option 2", "Option 3"]
    
    // 선택한 옵션을 저장할 상태 변수
    @State private var selectedOption: String?
    
    @State private var showingPopup = false
    
    var body: some View {
        VStack(alignment: .leading) {
//            Text("알림 주기 설정").font(.headline).padding(.bottom, 5)
            
            // 알림 주기를 설정하는 버튼 (팝업 뷰 표시)
            Button(action: {
                // 팝업 표시
                self.showingPopup = true
            }) {
                Text("알림 주기 설정")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .popover(isPresented: $showingPopup, content: {
                VStack {
                    Text("알림 주기 선택")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    // Picker를 사용하여 옵션 선택
                    Picker("알림 주기", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    // 확인 버튼
                    Button(action: {
                        // 선택한 옵션을 메모의 notification에 할당
                        self.notification = selectedOption
                        // 팝업 닫기
                        self.showingPopup = false
                    }) {
                        Text("확인")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                .padding()
            })
        }
        .padding()
    }
}

struct SecondScreen: View {
    // 두 번째 화면
    var memo: Memo
    
    var body: some View {
        VStack {
            Text("선택한 폴더에 저장 완료").font(.title).padding()
            // 방금 등록한 메모의 정보 표시
            Text("제목: \(memo.title )")
            Text("내용: \(memo.content )")
            Text("알림 주기: \(memo.notification ?? "")")
            Text("태그: \(memo.tags.joined(separator: ", "))")
            HStack {
                // 왼쪽 버튼은 코멘트 남기기
                Button(action: {}) {
                    Text("코멘트 남기기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                // 오른쪽 버튼은 앱에서 보기
                Button(action: {}) {
                    Text("앱에서 보기")
                        .foregroundColor(.purple)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

