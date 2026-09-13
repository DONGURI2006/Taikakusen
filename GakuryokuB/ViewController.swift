//
//  ViewController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/08/25.
//

import UIKit
import ACEDrawingView

class ViewController: UIViewController {
    var Rank: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Rank1(_ sender: Any) {
        self.Rank = 1
        performSegue(withIdentifier: "goNext", sender: nil)
    }
    
    @IBAction func Rank2(_ sender: Any) {
        self.Rank = 2
        performSegue(withIdentifier: "goNext", sender: nil)
    }
    
    @IBAction func Rank3(_ sender: Any) {
        self.Rank = 3
        performSegue(withIdentifier: "goNext", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goNext" {
            
            if let GoNext = segue.destination as? StartController {
                
                GoNext.self.RankNumber = self.Rank
            }
        }
    }
}
