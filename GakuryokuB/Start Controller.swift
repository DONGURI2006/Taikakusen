//
//  Start Controller.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/08/31.
//

import UIKit

class StartController: UIViewController {
    var Hp1:Int = 20
    var Hp2:Int = 20
    var Hp1GageNumber:Float = 20
    var Hp2GageNumber:Float = 20
    var Hp1DownNumber:Float = 0
    var Hp2DownNumber:Float = 0
    
    var Player1Image: UIImage?
    var Player2Image: UIImage?
    var Busyu = ["宀","⺅","⺾","彳","扌","氵"]
    var Busyu2 = ["うかんむり","にんべん","くさかんむり","ぎょうにんべん","てへん","さんずい"]

    var randomBusyu = ""
    var randomBusyu2 = ""
    var randomBusyuNum = 0
    var RankNumber: Int = 0
    var CountNumber: Int = 0
    
    @IBOutlet weak var TitleName: UILabel!
    
    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLoad() {
        if(self.CountNumber == 0){
            let randomIndex = Int.random(in: 0..<6)
            self.randomBusyu = self.Busyu[randomIndex]
            self.randomBusyu2 = self.Busyu2[randomIndex]
            
        }
       
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let TapAction = UITapGestureRecognizer(target: self,
                                               action: #selector(ScreenTapped))
        
        view.addGestureRecognizer(TapAction)
        
        
    }
    
    @objc func ScreenTapped() {
        performSegue(withIdentifier: "goBattle", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goBattle" {
            
            if let GoBattle = segue.destination as? BattleController {
                
                GoBattle.self.RankNumber = self.RankNumber
                GoBattle.self.BattlepPlayer = self.CountNumber
                GoBattle.self.Hp1 = self.Hp1
                GoBattle.self.Hp2 = self.Hp2
                GoBattle.self.Hp1GageNumber = self.Hp1GageNumber
                GoBattle.self.Hp2GageNumber = self.Hp2GageNumber
                GoBattle.self.Player1Image = self.Player1Image
                GoBattle.self.Player2Image = self.Player2Image
                GoBattle.self.Busyu = self.randomBusyu
                GoBattle.self.Busyu2 = self.randomBusyu2
                GoBattle.self.Hp1DownNumber = self.Hp1DownNumber
                GoBattle.self.Hp2DownNumber = self.Hp2DownNumber
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(self.CountNumber == 0){
            self.TitleName.text = "先攻"
            self.Name.text = "先攻の人にスマホを渡してください"
            
            self.CountNumber += 1
        }else{
            self.TitleName.text = "後攻"
            self.Name.text = "後攻の人にスマホを渡してください"
            self.CountNumber = 0
        }
    }


}
