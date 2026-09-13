//
//  FinalController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/09/04.
//

import UIKit

class FinalController: UIViewController {
    @IBOutlet weak var Hp1Back: UIView!
    @IBOutlet weak var Hp2Back: UIView!
    @IBOutlet weak var HpGage1: UIView!
    @IBOutlet weak var HpGage2: UIView!
    @IBOutlet weak var Hp1Number: UILabel!
    @IBOutlet weak var Hp2Number: UILabel!
    
    @IBOutlet weak var Hp1Gage: UIProgressView!
    @IBOutlet weak var Hp2Gage: UIProgressView!

    @IBOutlet weak var ResultText: UILabel!
    
    var MaxHP:Float = 20
    var Hp1:Int = 10
    var Hp2:Int = 10
    var Hp1GageNumber:Float = 10
    var Hp2GageNumber:Float = 10
    var RankNumber: Int = 0
    var BattlepPlayer: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        updateHP(Gage: self.HpGage1,Back: self.Hp1Back,Hp: self.Hp1GageNumber,MaxHP: self.MaxHP)
        updateHP(Gage: self.HpGage2,Back: self.Hp2Back,Hp: self.Hp2GageNumber,MaxHP: self.MaxHP)
        
        self.Hp1Number.text = String(Int(self.Hp1GageNumber))
        self.Hp2Number.text = String(Int(self.Hp2GageNumber))
        
        if(self.Hp1GageNumber < 11 && self.Hp1GageNumber > 5){
            self.HpGage1.backgroundColor = UIColor(red: 227/255, green: 216/255, blue: 94/255, alpha: 1.0)
        }else if(self.Hp1GageNumber < 6){
            self.HpGage1.backgroundColor = UIColor(red: 255/255, green: 78/255, blue: 78/255, alpha: 1.0)
        }else{
            self.HpGage1.backgroundColor = UIColor(red: 180/255, green: 221/255, blue: 69/255, alpha: 1.0)
        }
        
        if(self.Hp2GageNumber < 11 && self.Hp2GageNumber > 5){
            self.HpGage2.backgroundColor = UIColor(red: 227/255, green: 216/255, blue: 94/255, alpha: 1.0)
        }else if(Hp2GageNumber < 6){
            self.HpGage2.backgroundColor = UIColor(red: 255/255, green: 78/255, blue: 78/255, alpha: 1.0)
        }else{
            self.HpGage2.backgroundColor = UIColor(red: 180/255, green: 221/255, blue: 69/255, alpha: 1.0)
        }
        
        if(self.Hp1GageNumber > self.Hp2GageNumber){
            self.ResultText.text = "先攻の勝ち!!"
        }else{
            self.ResultText.text = "後攻の勝ち!!"
        }
    }
    
    func updateHP(Gage: UIView,Back: UIView,Hp: Float,MaxHP: Float) {

        let GageNum = CGFloat(Hp/MaxHP)
        let GageWidth = (Back.frame.width - 20) * GageNum
        Gage.frame.size.width = GageWidth
    }
    

    @IBAction func oneMore(_ sender: Any) {
        if let navigationController = navigationController {
            for controller in navigationController.viewControllers {
                if let startController = controller as? StartController {
                    startController.self.Hp1 = 10
                    startController.self.Hp2 = 10
                    startController.self.Hp1GageNumber = 10
                    startController.self.Hp2GageNumber = 10
                    navigationController.popToViewController(startController,animated: true)
                    return
                }
            }
        }
    }
    
    @IBAction func goTitle(_ sender: Any) {
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
}
