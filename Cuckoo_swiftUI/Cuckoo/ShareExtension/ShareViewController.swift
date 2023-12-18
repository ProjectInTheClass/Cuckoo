//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/29.
//

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
            if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String) { (item, error) in
                    if let url = item as? URL {
                        let urlString = url.absoluteString
                        DispatchQueue.main.async {
                            let vc = UIHostingController(rootView: FirstSharedView(linkURL: urlString, onClose: {
                                self.hideExtensionWithCompletionHandler { finished in
                                    if finished {
                                        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                                    }
                                }
                            }, onOpenInApp: { url in //TODO : fix 'Extra argument 'onOpenInApp' in call'
                                self.openURL(url)
                            }))
                            
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
                }
            }
        }
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
    
//    @objc func openURL(_ url: URL) {
//        // Implement your logic to open the URL in your app
//        // For example, you can use UIApplication.shared.openURL(url)
//    }
}

