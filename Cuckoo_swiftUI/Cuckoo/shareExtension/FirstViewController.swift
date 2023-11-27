//
//  FirstViewController.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/18.
//

import Foundation
import UIKit
import Social
import UniformTypeIdentifiers

class tags{
    var tagtitle : String
    var color : UIColor
    var numofMemo : Int = 0
    
    init(tagtitle: String, color: UIColor) {
        self.tagtitle = tagtitle
        self.color = color
    }
    
    init(tagtitle: String, color: UIColor, numofMemo: Int) {
        self.tagtitle = tagtitle
        self.color = color
        self.numofMemo = numofMemo
    }
}

// Add AlertPeriod struct definition
struct AlertPeriod {
    var title: String
    var cornerRadius: CGFloat
}

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var tagsData: [tags] = []//tags from db
    var alertPeriods: [AlertPeriod] = []
    var tagSelectedNum : Int = 0
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var linkURL: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var alertPeriodButton: UIButton!
    @IBOutlet weak var firstView: UIView!
    
    @IBAction func closeFirstView(_ sender: Any) {
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    @IBAction func registerAndMove(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        firstView.isHidden = true
        nextVC.previousViewController = self
        
        /*TODO 제목 겹칠시 로직 확정해야 됨!! */
        nextVC.titleString = commentTextView.text
        
        //        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this gets the incoming information from the share sheet
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier((UTType.url.identifier as CFString) as String) {
                        attachment.loadItem(forTypeIdentifier: (UTType.url.identifier as CFString) as String) { url, error in
                            guard error == nil, let url = url as? NSURL, let urlString = url.absoluteString else {
                                print("Failed to load URL")
                                return
                            }
                            
                            // Update the linkURL text
                            DispatchQueue.main.async {
                                self.linkURL.text = urlString
                            }
                        }
                    }
                }
            }
        }
        
        // Configure your initial tags
        tagsData.append(tags(tagtitle: "태그 추가", color: .red))
        tagsData.append(tags(tagtitle: "메모", color: .blue))
        tagsData.append(tags(tagtitle: "개발", color: .green))
        
        tagsData.append(contentsOf: [
            tags(tagtitle: "태그1", color: .green),
            tags(tagtitle: "태그2", color: .green),
            tags(tagtitle: "태그3", color: .green),
            tags(tagtitle: "태그4", color: .green),
            tags(tagtitle: "태그5", color: .green),
            tags(tagtitle: "태그6", color: .green),
            tags(tagtitle: "태그7", color: .green),
            tags(tagtitle: "태그8", color: .green),
            tags(tagtitle: "태그9", color: .green),
            tags(tagtitle: "태그10", color:.green)
        ])
        
        // Register the custom tag cell
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        
        // Set the delegate and dataSource
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        //design of view
        firstView.clipsToBounds = true
        /*
         " subview들이 view의 bounds에 가둬질 수 있는 지를 판단하는 Boolean 값 "
         즉, true로 설정하면 subview가 view의 경계를 넘어갈 시 잘리며 false로 설정하면 경계를 넘어가도 잘리지 않게 되는 것!
         */
        firstView.layer.cornerRadius = 30
        firstView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        
        //design of alertPeriod
        // Configure the alertPeriodButton as a pulldown menu
        alertPeriodButton.layer.cornerRadius = 5
        alertPeriodButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // Initialize the array with default values
        alertPeriods = [
            AlertPeriod(title: "7일 주기", cornerRadius: 15),
            AlertPeriod(title: "14일 주기", cornerRadius: 30)
        ]
        
        
        if let layout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 8  // You can adjust the spacing between cells as needed
        }
        
        //        // at the end of viewDidLoad
        //        NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
        //            self.close()
        //        }
        //
        //        // add this function to UIShareViewController
        //        func close() {
        //            extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        //        }
    }
    
    //    func close() {
    //        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)
    //    }
    //
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsData.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        
        // Configure the cell with tag data
        let tag = tagsData[indexPath.item]
        cell.configure(with: tag)
        
        return cell
    }
    
    // 한 줄로 만드는데 영향을 주지는 못하고 있는 듯
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = tagCollectionView.frame.width
        let cellHeight: CGFloat = 50.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //alertPeriodButton 동작 => alert
    // Function to show the pulldown menu
    @objc func showAlertPeriodMenu() {
        let alertController = UIAlertController(title: "주기 선택",message: nil, preferredStyle: .actionSheet)
        for alertPeriod in alertPeriods {
            let action = UIAlertAction(title: alertPeriod.title,style: .default) { _ in
                self.updateButtonCorner(radius:alertPeriod.cornerRadius)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    // Function to update the corner radius of the alertPeriodButton
    func updateButtonCorner(radius: CGFloat) {
        alertPeriodButton.layer.cornerRadius = radius
        alertPeriodButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0, y:self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    //second viewcontroller에서 'X' 누르면 종료
    func shutAllView(){
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    func countSelectedTags(){
        //tagCollectionView의 Cell들의 Button이 selected 됐는지 확인
    }
}

class SecondViewController: UIViewController{
    
    var titleString : String?
    
    enum AppError: Error {
        case targetAppNotInstalled
        case unableToOpenTargetApp
    }
    
    @IBAction func closeAllView(_ sender: Any) {
        dismiss(animated: true){
            self.previousViewController?.shutAllView()
        }
    }
    
    @IBAction func moveToApp(_ sender: Any) {
//        // Replace "target-app://" with the actual URI scheme of the target app
        let targetAppURL = URL(string: "CuckooApp://")!
////        let mySceneDelegate = self.view.window?.windowScene.delegate
//        
        // Verify if the target app is installed
//        if UIApplication.shared.canOpenURL(targetAppURL) {
//            // Open the target app
//            UIApplication.shared.open(targetAppURL, options: [:]) { success in
//                if !success {
//                    // Handle the case where the target app could not be opened
//                    let error = AppError.unableToOpenTargetApp
//                    self.showAlert(for: error)
//                }
//            }
//        } else {
//            // Handle the case where the target app is not installed
//            let error = AppError.targetAppNotInstalled
//            showAlert(for: error)
//        }
        self.previousViewController?.hideExtensionWithCompletionHandler(completion: { _ in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    @IBOutlet weak var secondView: UIView!
    
    var previousViewController : FirstViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view design
        secondView.clipsToBounds = true
        secondView.layer.cornerRadius = 30
        secondView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
    }
    
    func showAlert(for error: Error) {
        var errorMessage: String

        switch error {
        case AppError.targetAppNotInstalled:
            errorMessage = "Target app is not installed."
        case AppError.unableToOpenTargetApp:
            errorMessage = "Unable to open the target app."
        default:
            errorMessage = "Unknown error"
        }

        let alertController = UIAlertController(
            title: "Error",
            message: errorMessage,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))

        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
}

