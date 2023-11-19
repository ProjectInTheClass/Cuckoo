//
//  FirstViewController.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/18.
//

import Foundation
import UIKit

class tags{
    var tagtitle : String
    var color : String
    init(tagtitle: String, color: String) {
        self.tagtitle = tagtitle
        self.color = color
    }
}

// Custom UICollectionViewCell for tags
class TagCollectionViewCell: UICollectionViewCell {

    let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        // Set your desired font
        label.font = UIFont.systemFont(ofSize: 14)
        // Set your desired background color
        label.backgroundColor = UIColor.lightGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(tagLabel)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func configure(with tag: tags) {
            tagLabel.text = tag.tagtitle
            // Use the tag's color
            tagLabel.backgroundColor = UIColor(named: tag.color)
            tagLabel.textColor = UIColor.black
    }
}


class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var tagsData: [tags] = []
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var linkURL: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBAction func closeFirstView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func alertPeriodButton(_ sender: Any) {
    }
    
    @IBAction func registerAndMove(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        firstView.isHidden = true
        nextVC.previousViewController = self
//        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure your initial tags
        tagsData.append(tags(tagtitle: "태그 추가", color: "Red"))
        tagsData.append(tags(tagtitle: "메모", color: "Orange"))
        tagsData.append(tags(tagtitle: "개발", color: "Yellow"))
        
        tagsData.append(contentsOf: [
                    tags(tagtitle: "태그1", color: "Green"),
                    tags(tagtitle: "태그2", color: "Green"),
                    tags(tagtitle: "태그3", color: "Green"),
                    tags(tagtitle: "태그4", color: "Green"),
                    tags(tagtitle: "태그5", color: "Green"),
                    tags(tagtitle: "태그6", color: "Green"),
                    tags(tagtitle: "태그7", color: "Green"),
                    tags(tagtitle: "태그8", color: "Green"),
                    tags(tagtitle: "태그9", color: "Green"),
                    tags(tagtitle: "태그10", color: "Green"),
                    tags(tagtitle: "태그11", color: "Green"),
                    tags(tagtitle: "태그12", color: "Green"),
                    tags(tagtitle: "태그13", color: "Green"),
                    tags(tagtitle: "태그14", color: "Green"),
                    tags(tagtitle: "태그15", color: "Green")
                ])
        
        // Register the custom tag cell
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCell")

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
        
        if let layout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 8  // You can adjust the spacing between cells as needed
        }
    }
    
    func revealView(){
        firstView.isHidden = false
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = tagCollectionView.frame.width
        let cellHeight: CGFloat = 50.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}

class SecondViewController: UIViewController{
    
    @IBAction func closeAllView(_ sender: Any) {
        dismiss(animated: true){
            self.previousViewController?.revealView()
        }
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
    

}

