//
//  Tags.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI

struct TypeBubble: View, Hashable {
    
    var title: String
    var hexCode: String
    var selected : Bool
    
    init(_ title: String, _ hexCode: String, selected : Bool = false){
        self.title = title
        self.hexCode = hexCode
        self.selected = selected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(hexCode)
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(selected ? .white : .black.opacity(0.7))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(selected ? Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255) : Color(hex: hexCode))
            )
            .cornerRadius(15)
    }
}

struct addTypeBubble : View{
    var body: some View{
        Text("+")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            .padding(6)
            .background(Color.red)
            .clipShape(Circle()) // 원형 모양으로 만듭니다.
    }
}

extension Color {
    
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
    func hexCode() -> String {
            if #available(iOS 14.0, *) {
                guard let components = UIColor(self).resolvedColor(with: UITraitCollection.current).cgColor.components else {
                    return "000000"
                }
                let red = Int(components[0] * 255.0)
                let green = Int(components[1] * 255.0)
                let blue = Int(components[2] * 255.0)
                return String(format: "#%02X%02X%02X", red, green, blue)
            } else {
                // Fallback on earlier versions
                return "000000"
            }
        }
}

extension UIColor {
    static let alertAccentColor = UIColor(named: "#FF4F4F")!
    static let cardBackgroundColor = UIColor(named: "#FAF4E5")!
    static let blockDarkColor = UIColor(named: "#4B4945")!
    static let blockDarkerColor = UIColor(named: "#7d7a73")!
    static let defaultPure = UIColor(named: "#C8C3B7")!
    static let cuckooRed = UIColor(named: "#95281d")!
    static let cuckooPurple = UIColor(named: "#69314c")!
    static let cuckooViolet = UIColor(named: "#492F64")!
    static let cuckooBlue = UIColor(named: "#28456C")!
    static let cuckooGreen = UIColor(named: "#2B593F")!
    static let cuckooYellow = UIColor(named: "#89632A")!
    static let cuckooCarrot = UIColor(named: "#854C1D")!
    static let cuckooBrown = UIColor(named: "#603B2C")!
    static let cuckooDeepGray = UIColor(named: "#5A5A5A")!
    static let cuckooLightGray = UIColor(named: "#D9D9D9")!
    static let backgroundColorCandidate = UIColor(named: "#FFFDF5")!
}
