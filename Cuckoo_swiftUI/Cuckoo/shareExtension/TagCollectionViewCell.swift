//
//  TagCollectionViewCell.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/20.
//

import UIKit

// Custom UICollectionViewCell for tags
class TagCollectionViewCell: UICollectionViewCell {
    
    var tagSelected : Bool = false

    @IBOutlet weak var tagCellButton: UIButton!
    
    @IBAction func changeTag(_ sender: Any){
        self.tagSelected = !(self.tagSelected)
        //음영 바꾸기
        if(self.tagSelected){
            //음영 생성
            backgroundColor = UIColor(named: "Black")
        }
        else{
            //음영 해제
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
//        tagCellButton.layer.cornerRadius = 8 // Adjust the corner radius as needed
//        tagCellButton.clipsToBounds = true
    }

    func configure(with tag: tags) {
        tagCellButton.setTitle(tag.tagtitle, for: .normal)
        tagCellButton.backgroundColor = UIColor(named: tag.color)
        tagCellButton.setTitleColor(.white, for: .normal)
    }
}
