import UIKit
import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

extension UIViewController {
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}

class ShareViewController: UIViewController {

    func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0, y: self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProviders = extensionItem.attachments else {
            return
        }

        for itemProvider in itemProviders {
            let types = itemProvider.registeredTypeIdentifiers
                    print("Available types: \(types)")
            if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String) { (item, error) in
                    self.handleSharedItem(item)
                }
            }
            
            else if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePlainText as String) { (item, error) in
                    self.handleSharedItem(item)
                }

            }
            
            else if  itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { (item, error) in
                    self.handleSharedItem(item)
                }

            }
                
        }
    }
    
    private func handleSharedItem(_ item: NSSecureCoding?) {
        let content = (item as? URL)?.absoluteString ?? (item as? String) ?? ""
        let extractedURL = self.extractURL(from: content)
        
        DispatchQueue.main.async {
            let vc = UIHostingController(rootView: FirstSharedView(linkURL: extractedURL, onClose: {
                self.hideExtensionWithCompletionHandler { finished in
                    if finished {
                        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                    }
                }
            }, onOpenInApp: { url in
                self.openURL(url)
            }))

            vc.overrideUserInterfaceStyle = .light  // 라이트 모드 강제 적용
            
            let swiftUIView = vc.view!
            swiftUIView.translatesAutoresizingMaskIntoConstraints = false
            self.addChild(vc)
            self.view.addSubview(swiftUIView)
            
            NSLayoutConstraint.activate([
                swiftUIView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                swiftUIView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                swiftUIView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                swiftUIView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 200)
            ])
            
            vc.didMove(toParent: self)
        }
    }
    
    private func extractURL(from text: String) -> String {
           let regex = try! NSRegularExpression(pattern: "http[s]?://[a-zA-Z0-9./?=&_-]+", options: .caseInsensitive)
           let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
           if let match = matches.first {
               let range = Range(match.range, in: text)
               return String(text[range!])
           }
           return ""
       }
    
    @objc private func openURL(_ url: URL) {
        guard let responder = self as UIResponder? else { return }
        let selector = #selector(openURL(_:))

        var currentResponder: UIResponder? = responder
        while currentResponder != nil {
            if currentResponder!.responds(to: selector) && currentResponder != self {
                currentResponder!.perform(selector, with: url)
                break
            }

            currentResponder = currentResponder?.next
        }
    }
}
