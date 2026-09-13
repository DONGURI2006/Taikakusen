//
//  TimeUpController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/09/01.
//

import UIKit

class TimeUpController: UIViewController {
    var Hp1:Int = 10
    var Hp2:Int = 10
    var Hp1GageNumber:Float = 10
    var Hp2GageNumber:Float = 10
    
    var Player1Image: UIImage?
    var Player2Image: UIImage?
    var RankNumber: Int = 0
    var BattlepPlayer: Int = 0
    var Busyu:String = ""
    var Busyu2:String = ""
    var Hp1DownNumber:Float = 0
    var Hp2DownNumber:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        print(self.BattlepPlayer)
        
        let TapAction = UITapGestureRecognizer(target: self,
                                               action: #selector(ScreenTapped))

        view.addGestureRecognizer(TapAction)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goResult" {
            
            if let GoResult = segue.destination as? GoResultController {
                
                GoResult.self.RankNumber = self.RankNumber
                GoResult.self.BattlepPlayer = self.BattlepPlayer
                
                GoResult.self.Hp1 = self.Hp1
                GoResult.self.Hp2 = self.Hp2
                GoResult.self.Hp1GageNumber = self.Hp1GageNumber
                GoResult.self.Hp2GageNumber = self.Hp2GageNumber
                GoResult.self.Player1Image = self.Player1Image
                GoResult.self.Player2Image = self.Player2Image
                GoResult.self.Busyu = self.Busyu
                GoResult.self.Busyu2 = self.Busyu2
                GoResult.self.Hp1DownNumber = self.Hp1DownNumber
                GoResult.self.Hp2DownNumber = self.Hp2DownNumber
            }
        }
    }
    @objc func ScreenTapped() {
        print("000")
        if (self.BattlepPlayer == 1){
            if let navigationController = navigationController {

                for controller in navigationController.viewControllers {

                    if let startController = controller as? StartController {

                        startController.self.Hp1 = self.Hp1
                        startController.self.Hp2 = self.Hp2

                        startController.self.Hp1GageNumber = self.Hp1GageNumber
                        startController.self.Hp2GageNumber = self.Hp2GageNumber
                        startController.self.Player1Image = self.Player1Image
                        startController.self.Player2Image = self.Player2Image
                        startController.self.randomBusyu = self.Busyu
                        startController.self.randomBusyu2 = self.Busyu2
                        startController.self.Hp1DownNumber = self.Hp1DownNumber
                        startController.self.Hp2DownNumber = self.Hp2DownNumber

                        navigationController.popToViewController(startController,animated: true)

                        return
                    }
                }
            }

        }
        else{
            self.performSegue(withIdentifier: "goResult", sender: nil)
        }
    }

}
