//
//  ResultController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/08/31.
//

import UIKit

class ResultController: UIViewController {
    @IBOutlet weak var Player1Img: UIImageView!
    @IBOutlet weak var Player2Img: UIImageView!
    
    @IBOutlet weak var Hp1Back: UIView!
    @IBOutlet weak var Hp2Back: UIView!
    @IBOutlet weak var HpGage1: UIView!
    @IBOutlet weak var HpGage2: UIView!
    @IBOutlet weak var Hp1Gage: UIProgressView!
    
    @IBOutlet weak var Hp2Gage: UIProgressView!
    @IBOutlet weak var LoserTitle: UILabel!
    @IBOutlet weak var LoserTitle2: UILabel!
    @IBOutlet weak var Hp1Number: UILabel!
    @IBOutlet weak var Hp2Number: UILabel!
    
    @IBOutlet weak var Odai: UILabel!
    @IBOutlet weak var Odai2: UILabel!
    @IBOutlet weak var RankTitle: UILabel!
    
    @IBOutlet weak var Player1Damege: UILabel!
    @IBOutlet weak var Player2Damege: UILabel!
    @IBOutlet weak var ResultDamege: UILabel!
    @IBOutlet weak var NextBattleBtn: UIButton!
    
    @IBOutlet weak var ConditionLabel: UILabel!
    @IBOutlet weak var ConditionLabel2: UILabel!
    
    @IBOutlet weak var ConditionLabel2_1: UILabel!
    @IBOutlet weak var ConditionLabel2_2: UILabel!
    var RankNumber: Int = 0
    var BattlepPlayer: Int = 0
    
    var Player1Image: UIImage?
    var Player2Image: UIImage?
    var Busyu:String = ""
    var Busyu2:String = ""
    var BusyuNum = 0
    var Busyu3 = ["宀","⺅","⺾","彳","扌","氵"]
    
    var Busyu4 = ["うかんむり","にんべん","くさかんむり","ぎょうにんべん","てへん","さんずい"]
    
    var MaxHP:Float = 20
    var Hp1:Int = 10
    var Hp2:Int = 10
    var Hp1GageNumber:Float = 10
    var Hp2GageNumber:Float = 10
    var Hp1DownNumber:Float = 0
    var Hp2DownNumber:Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        var Config = self.NextBattleBtn.configuration
        var Attributes = AttributeContainer()

        if let font = UIFont(name: "NotoSansJP-Bold",size: 24) {
            Attributes.font = font
        } else {
            Attributes.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        }
        print(self.Player1Image)
        print(self.Player2Image)
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.Player1Img.image = self.Player1Image
        self.Player2Img.image = self.Player2Image
        self.Player1Damege.text = String(Int(self.Hp1DownNumber))
        self.Player2Damege.text = String(Int(self.Hp2DownNumber))
        self.Odai.text = Busyu
        self.Odai2.text = "(\(Busyu2))"
        if(self.self.RankNumber == 1){
            self.RankTitle.text = "初級"
            self.ConditionLabel.text = "・なし"
            self.ConditionLabel2.text = ""
            self.ConditionLabel2_1.text = "・なし"
            self.ConditionLabel2_2.text = ""
        }
        else if(self.RankNumber == 2){
            self.RankTitle.text = "中級"
            self.ConditionLabel.text = "・3画以上"
            self.ConditionLabel2.text = "・10画以内"
            self.ConditionLabel2_1.text = "・3画以上"
            self.ConditionLabel2_2.text = "・10画以内"
        }
        else{
            self.RankTitle.text = "上級"
            self.ConditionLabel.text = "・11画以上"
            self.ConditionLabel2.text = ""
            self.ConditionLabel2_1.text = "・11画以上"
            self.ConditionLabel2_2.text = ""
        }
        
        self.Damage(DamageNumber1: self.Hp1DownNumber,DamageNumber2: self.Hp2DownNumber)
        
        
        
        self.updateHP(Gage: self.HpGage1,Back: self.Hp1Back,Hp: self.Hp1GageNumber,MaxHP: self.MaxHP)
        self.updateHP(Gage: self.HpGage2,Back: self.Hp2Back,Hp: self.Hp2GageNumber,MaxHP: self.MaxHP)
        
        self.Hp1Number.text = String(Int(self.Hp1GageNumber))
        self.Hp2Number.text = String(Int(self.Hp2GageNumber))
        
        if(self.Hp1GageNumber < 11 && self.Hp1GageNumber > 5){
            self.HpGage1.backgroundColor = UIColor(red: 227/255, green: 216/255, blue: 94/255, alpha: 1.0)
        }else if(Hp1GageNumber < 6){
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
        
        if Hp1GageNumber <= 0 || self.Hp2GageNumber <= 0 {
            Config?.attributedTitle = AttributedString("結果発表",attributes: Attributes)
        } else {
            Config?.attributedTitle = AttributedString("次のバトルへ",attributes: Attributes)
        }

        self.NextBattleBtn.configuration = Config

    }
    
    func updateHP(Gage: UIView,Back: UIView,Hp: Float,MaxHP: Float) {

        let GageNum = CGFloat(Hp / MaxHP)

        let GageWidth = (Back.frame.width - 20) * GageNum
            
        Gage.frame.size.width = GageWidth

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goFinal" {
            
            if let Final = segue.destination as? FinalController {
                
                Final.self.RankNumber = self.RankNumber
                Final.self.BattlepPlayer = self.BattlepPlayer
                Final.self.Hp1 = self.Hp1
                Final.self.Hp2 = self.Hp2
                Final.self.Hp1GageNumber = self.Hp1GageNumber
                Final.self.Hp2GageNumber = self.Hp2GageNumber
                
            }
        }
    }
    func Damage(DamageNumber1: Float,DamageNumber2: Float) {
        
        if (DamageNumber1 < DamageNumber2){
            self.Hp1GageNumber -= DamageNumber2 - DamageNumber1
            self.ResultDamege.text  = String(Int(DamageNumber2 - DamageNumber1))
            self.LoserTitle.text = "先攻"
            self.LoserTitle2.text = "へ"
        }else if (DamageNumber1 > DamageNumber2){
            self.Hp2GageNumber -= DamageNumber1 - DamageNumber2
            
            self.ResultDamege.text  = String(Int(DamageNumber1 - DamageNumber2))
            self.LoserTitle.text = "後攻"
            self.LoserTitle2.text = "へ"
        }else{
            self.LoserTitle.text = "同点"
            self.LoserTitle2.text = ""
        }

        if self.Hp1GageNumber < 0 {
            self.Hp1GageNumber = 0
        }
        if self.Hp2GageNumber < 0 {
            self.Hp2GageNumber = 0
        }
        

    }
    @IBAction func NextBattle(_ sender: Any) {
        
        if(self.Hp1GageNumber <= 0 || self.Hp2GageNumber <= 0){
            self.performSegue(withIdentifier: "goFinal", sender: nil)
        }else{
            if let navigationController = navigationController {

                for controller in navigationController.viewControllers {

                    if let startController = controller as? StartController {

                        startController.self.Hp1 = self.Hp1
                        startController.self.Hp2 = self.Hp2

                        startController.self.Hp1GageNumber = self.Hp1GageNumber
                        startController.self.Hp2GageNumber = self.Hp2GageNumber
                        startController.self.Hp1DownNumber = 0
                        startController.self.Hp2DownNumber = 0
                        startController.self.Player1Image = nil
                        startController.self.Player2Image = nil
                        
                        let randomIndex = Int.random(in: 0..<6)
                        
                        startController.self.randomBusyu = self.Busyu3[randomIndex]
                        startController.self.randomBusyu2 = self.Busyu4[randomIndex]

                        navigationController.popToViewController(startController,animated: true)

                        return
                    }
                }
            }
            

        }
        
    }
    
    

}
