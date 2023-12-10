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
    
class ShareViewController: UIViewController {
    
    var image: UIImage = UIImage(systemName: "star.fill")!
    
    func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0, y: self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let extensionItems = extensionContext?.inputItems as! [NSExtensionItem]
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { result, error in
                            if let url = result as? URL {
                                let urlString = url.absoluteString
                                DispatchQueue.main.async {
                                    
                                    let vc = UIHostingController(rootView: FirstSharedView(linkURL: urlString, image: self.image, onClose: {
                                        // Dismiss the extension view controller
                                        self.hideExtensionWithCompletionHandler { finished in
                                            if finished {
                                                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                                            }
                                        }
                                    }, tagButtonList: dummyTagList, presetButtonList: presetButtonList))

                                    let swiftUIView = vc.view!
                                    swiftUIView.translatesAutoresizingMaskIntoConstraints = false
                                    self.addChild(vc)
                                    self.view.addSubview(swiftUIView)

                                    NSLayoutConstraint.activate([
                                        swiftUIView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        swiftUIView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                        swiftUIView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                    ])

                                    vc.didMove(toParent: self)
                                }
                            }
                        })
                    }
                }
            }
        }
    }
}

