//
//  GoResultController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/09/01.
//

import UIKit

class GoResultController: UIViewController {
    var Hp1:Int = 10
    var Hp2:Int = 10
    var Hp1GageNumber:Float = 10
    var Hp2GageNumber:Float = 10
    var Hp1DownNumber:Float = 0
    var Hp2DownNumber:Float = 0
    
    var RankNumber: Int = 0
    var BattlepPlayer: Int = 0
    var Busyu:String = ""
    var Busyu2:String = ""
    
    var Player1Image: UIImage?
    var Player2Image: UIImage?
    
    override func viewDidLoad() {
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        print(self.BattlepPlayer)
        print(self.RankNumber)
        super.viewDidLoad()
        
        let TapAction = UITapGestureRecognizer(target: self,
                                               action: #selector(ScreenTapped))

        view.addGestureRecognizer(TapAction)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Result" {
            
            if let Result = segue.destination as? ResultController {
                
                Result.self.RankNumber = self.RankNumber
                Result.self.BattlepPlayer = self.BattlepPlayer
                
                Result.self.Hp1 = self.Hp1
                Result.self.Hp2 = self.Hp2
                Result.self.Hp1GageNumber = self.Hp1GageNumber
                Result.self.Hp2GageNumber = self.Hp2GageNumber
                
                Result.self.Player1Image = self.Player1Image
                Result.self.Player2Image = self.Player2Image
                Result.self.Busyu = self.Busyu
                Result.self.Busyu2 = self.Busyu2
                Result.self.Hp1DownNumber = self.Hp1DownNumber
                Result.self.Hp2DownNumber = self.Hp2DownNumber
            }
        }
    }
    @objc func ScreenTapped() {

        self.performSegue(withIdentifier: "Result", sender: nil)

    }

}
