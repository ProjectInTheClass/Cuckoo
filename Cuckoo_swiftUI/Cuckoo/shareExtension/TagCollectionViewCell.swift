//
//  TagCollectionViewCell.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/20.
//

import UIKit

// Custom UICollectionViewCell for tags
class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagCellButton: UIButton!
    
    @IBAction func changeTag(_ sender: Any){
        isSelected = !isSelected
        // Customize appearance when selected
                if isSelected {
                    tagCellButton.layer.borderColor = UIColor.black.cgColor
//                    tagCellButton.layer.borderWidth = 2.0
                } else {
                    tagCellButton.layer.borderColor = UIColor.clear.cgColor
//                    tagCellButton.layer.borderWidth = 0.0
                }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with tag: tags) {
        tagCellButton.isSelected = false
        tagCellButton.layer.cornerRadius = 8 // Adjust the corner radius as needed
        tagCellButton.clipsToBounds = true
        tagCellButton.setTitle(tag.tagtitle, for: .normal)
        tagCellButton.backgroundColor = tag.color
        tagCellButton.setTitleColor(.black, for: .normal)
    }
}
