//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/29.
//

import UIKit
import SwiftUI
import Social
import UniformTypeIdentifiers
import MobileCoreServices
import Combine


extension UIViewController {
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
    
class ShareViewController: UIViewController {
    var image: UIImage = UIImage(systemName: "star.fill")!
    
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
        let extensionItems = extensionContext?.inputItems as! [NSExtensionItem]
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) {
                            (item, error) in
                            if let url = item as? URL {
                                let urlString = url.absoluteString
                                DispatchQueue.main.async {
                                    
                                    
                                    // TODO :: FirstSharedView가 하단에 붙어 나오되,
                                    // 내부에서 ScrollView 등이 잘 동작해야함.
                                    let vc = UIHostingController(rootView: FirstSharedView(linkURL: urlString,  onClose: {
                                        // Dismiss the extension view controller
                                        self.hideExtensionWithCompletionHandler { finished in
                                            if finished {
                                                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                                            }
                                        }
                                    }))
                                    
                                    let swiftUIView = vc.view!
                                    swiftUIView.translatesAutoresizingMaskIntoConstraints = false
                                    self.addChild(vc)
                                    self.view.addSubview(swiftUIView)
                                    
                                    
                                    NSLayoutConstraint.activate([
                                        swiftUIView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        swiftUIView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                        swiftUIView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                        swiftUIView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 200) // 예시 높이값, 필요에 따라 조정
                                    ])
                                    
                                    vc.didMove(toParent: self)
                                }
                            }
                        }
                    }
                }
            }
        } // for
    } // viewDidLoad
}
