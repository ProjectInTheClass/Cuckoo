//
//  ShareViewController.swift
//  shareExtension
//
//  Created by 유철민 on 2023/11/10.
//

//import UIKit
//import Social
//
//class ShareViewController: SLComposeServiceViewController {
//
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }
//
//}


import SwiftUI

//ShareViewController 수정
class ShareViewController: UIViewController {
    @IBOutlet var container: UIView!

    // in ShareViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // this gets the incoming information from the share sheet
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.text") {
                        attachment.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: { text, _ in

                            // text variable is the text from the share sheet...
                            // this will add your SwiftUI View to the UIViewController
                            //let childView = UIHostingController(rootView: AirlistShareView(name: text as! String, note: ""))
                            //self.addChild(childView)
                            //childView.view.frame = self.container.bounds
                            //self.container.addSubview(childView.view)
                            //childView.didMove(toParent: self)
                            // text variable is the text from the share sheet...
                            let childView = UIHostingController(rootView: SwiftUIView(incoming_text: text as! String))
                            self.addChild(childView)
                            childView.view.frame = self.container.bounds
                            self.container.addSubview(childView.view)
                            childView.didMove(toParent: self)
                        })
                    }
                }
            }
        }
        
        // at the end of viewDidLoad
        NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
            self.close()
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // add this function to UIShareViewController
    func close() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
}

//swiftUI view 설정
struct SwiftUIView : View{
    @State public var incoming_text: String
    
    var body: some View {
        Text(incoming_text)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(incoming_text: "Preview Text")
    }
}
