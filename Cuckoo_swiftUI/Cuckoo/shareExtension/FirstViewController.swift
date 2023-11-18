//
//  FirstViewController.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/11/18.
//

import Foundation
import UIKit

class FirstViewController: UIViewController{
    
    @IBAction func closeFirstView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var firstView: UIView!
    
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
        
        firstView.clipsToBounds = true
        /*
         " subview들이 view의 bounds에 가둬질 수 있는 지를 판단하는 Boolean 값 "
         즉, true로 설정하면 subview가 view의 경계를 넘어갈 시 잘리며 false로 설정하면 경계를 넘어가도 잘리지 않게 되는 것!
         */
        firstView.layer.cornerRadius = 30
        firstView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    func revealView(){
        firstView.isHidden = false
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
