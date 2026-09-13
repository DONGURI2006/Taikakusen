//
//  RuleController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/08/26.
//

import UIKit

class RuleController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var SclollView: UIScrollView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    var Page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PageControl.currentPage = self.Page
        
        self.SclollView.isScrollEnabled = false
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        self.Page += 1
        if(self.Page > 5){
            self.Page = 5
        }
        
        self.MovePage()
    }
    
    @IBAction func BeforeBtn(_ sender: Any) {
        self.Page -= 1
        if(self.Page < 0){
            self.Page = 0
        }
        self.MovePage()
    }
    func MovePage(){
        let X = CGFloat(self.Page) * 414
        
        self.SclollView.setContentOffset(CGPoint(x: X, y: 0),animated: true)
        
        self.PageControl.currentPage = self.Page
    }
}
