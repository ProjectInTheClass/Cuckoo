//
//  tags.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/26.
//

import Foundation
import SwiftUI

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
    
    // Configure your initial tags
    var tag1 = tags(tagtitle: "유튜브", color: .red, numofMemo : 3)
    var tag2 = tags(tagtitle: "메모", color: .blue, numofMemo : 4)
    var tag3 = tags(tagtitle: "개발", color: .green, numofMemo : 2)
}


