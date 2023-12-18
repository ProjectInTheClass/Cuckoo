//
//  ViewComponents.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine
import CoreData 

struct HeaderView: View {
    var title: String = ""
    var isRoot: Bool = false

    // 현재 뷰를 닫는 데 사용됩니다.
    @SwiftUI.Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()
            HStack {
                // 뒤로 가기 버튼
                Spacer()
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                
                Spacer()
            }.overlay(alignment: .leading) {
                if isRoot {
                    //
                } else {
                    Button(action: {
                        // 뒤로 가기 액션
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30)
                }
            }
        }
    }
}

struct BarDivider: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(height: 0.2)
      .overlay(
        Rectangle()
          .stroke(
            Color(red: 0, green: 0, blue: 0).opacity(0.10), lineWidth: 0.50
          )
      );
  }
}


struct ConfirmFixedButton: View {
    var confirmMessage: String
    var logic : () -> Void
    
    var body: some View {
        VStack {
            Button {
                logic()
            }label: {
                Text(confirmMessage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
            }}
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.purple)
        .cornerRadius(15)
        .padding(.horizontal, 30)
        
    }
}


/*
    * 이하는 Alarm Preset 관련 Component
*/


struct presetButton : Hashable{// Hash=> 기억해두자
    var emoji : String
    var alarmName : String
    var time : String
    var preset_id : NSManagedObjectID
    init(emoji: String, alarmName: String, time: String, preset_id : NSManagedObjectID) {
        self.emoji = emoji
        self.alarmName = alarmName
        self.time = time
        self.preset_id = preset_id
    }
    
    // Implementing the Hashable protocol => 기억해두자
    func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
        hasher.combine(alarmName)
        hasher.combine(time)
        hasher.combine(preset_id)
    }
}

// Custom button style for Notification Buttons => 이렇게 따로 만들 수 있다.
struct NotificationButtonStyle: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(selected ? Color.cuckooSignature : Color.superPure)
            .foregroundColor(selected ? .white : .black)
            .cornerRadius(10)
    }
}

// Color Components

import SwiftUI

extension Color {
    static let alertAccent = Color(red: 1.00, green: 0.31, blue: 0.31)
    static let cardBackground = Color(red: 0.8705, green: 0.8705, blue: 0.8705)

    static let blockDark = Color(red: 0.29, green: 0.29, blue: 0.27)
    static let blockDarker = Color(red: 0.49, green: 0.48, blue: 0.45)
    static let defaultPure = Color(red: 0.78, green: 0.76, blue: 0.72)
    static let cuckooRed = Color(red: 0.58, green: 0.16, blue: 0.11)
    static let cuckooPurple = Color(red: 0.41, green: 0.19, blue: 0.30)
    static let cuckooViolet = Color(red: 0.29, green: 0.18, blue: 0.39)
    static let cuckooBlue = Color(red: 0.16, green: 0.27, blue: 0.42)
    static let cuckooGreen = Color(red: 0.17, green: 0.35, blue: 0.25)
    static let cuckooYellow = Color(red: 0.54, green: 0.39, blue: 0.16)
    static let cuckooCarrot = Color(red: 0.52, green: 0.30, blue: 0.11)
    static let cuckooBrown = Color(red: 0.38, green: 0.23, blue: 0.17)
    static let cuckooDeepGray = Color(red: 0.35, green: 0.35, blue: 0.35)
    static let cuckooNormalGray = Color(red: 0.7, green: 0.7, blue: 0.7)
    static let cuckooLightGray = Color(red: 0.85, green: 0.85, blue: 0.85)
    static let backgroundCandidate = Color(red: 1.00, green: 0.99, blue: 0.96)
    static let cuckooSignature = Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255)
    static let superPure = Color(red: 245 / 255, green: 244 / 255, blue: 244 / 255)
    
    func toHex() -> String? {
            let uiColor = UIColor(self)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0

            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0

            return String(format:"#%06x", rgb)
        }
    
    static func fromHex(_ hex: String) -> Color {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            Scanner(string: hexSanitized).scanHexInt64(&rgb)

            let red = Double((rgb & 0xFF0000) >> 16) / 255.0
            let green = Double((rgb & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgb & 0x0000FF) / 255.0

            return Color(red: red, green: green, blue: blue)
        }
}

/*
 [Color 사용 예시]
 Rectangle()
     .fill(Color.cuckooLightGray)
 */


// 이하는 키보드 숨기기용


// Back Swipe

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
}
