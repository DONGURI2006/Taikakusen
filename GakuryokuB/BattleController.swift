//
//  BattleController.swift
//  GakuryokuB
//
//  Created by 平井　登惟 on 2026/08/26.
//

import UIKit
import ACEDrawingView
import SwiftyJSON

class BattleController: UIViewController,GeminiUtilDelegate, ACEDrawingViewDelegate {
    
    
    @IBOutlet weak var YesOrNotImg: UIImageView!
    @IBOutlet weak var Hp1Back: UIView!
    @IBOutlet weak var Hp2Back: UIView!
    @IBOutlet weak var Hp1Number: UILabel!
    @IBOutlet weak var Hp2Number: UILabel!
    
    @IBOutlet weak var Hp1Gage: UIProgressView!
    @IBOutlet weak var Hp2Gage: UIProgressView!
    @IBOutlet weak var HpGage1: UIView!
    @IBOutlet weak var HpGage2: UIView!
    @IBOutlet weak var CountNumber: UILabel!
    @IBOutlet weak var ConditionLabel: UILabel!
    @IBOutlet weak var RankTitle: UILabel!
    
    @IBOutlet weak var ConditionLabel2: UILabel!

    @IBOutlet weak var OdaiText: UILabel!
    @IBOutlet weak var OdaiText2: UILabel!
    
    var Player1Image: UIImage?
    var Player2Image: UIImage?
    
    
    var MaxHP:Float = 20
    var Hp1:Int = 10
    var Hp2:Int = 10
    var Hp1GageNumber:Float = 10
    var Hp2GageNumber:Float = 10
    var Hp1DownNumber:Float = 0
    var Hp2DownNumber:Float = 0
    var Busyu:String = ""
    var Busyu2:String = ""
    var DrawCount: Int = 0
    
    var RankNumber: Int = 0
    var BattlepPlayer: Int = 0
    var CountTimer: Timer?
    var TimeCount:Int = 60
    var TimeOut:Bool = true
    
    @IBOutlet weak var drawView: ACEDrawingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.DrawCount = 0
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        GeminiUtil.shared.delegate = self
        print(self.BattlepPlayer)
        
        print(self.RankNumber)
        
        self.updateHP(Gage: self.HpGage1,Back: self.Hp1Back,Hp: self.Hp1GageNumber,MaxHP: self.MaxHP)
        self.updateHP(Gage: self.HpGage2,Back: self.Hp2Back,Hp: self.Hp2GageNumber,MaxHP: self.MaxHP)
        
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
        }else if(self.Hp2GageNumber < 6){
            self.HpGage2.backgroundColor = UIColor(red: 255/255, green: 78/255, blue: 78/255, alpha: 1.0)
        }else{
            self.HpGage2.backgroundColor = UIColor(red: 180/255, green: 221/255, blue: 69/255, alpha: 1.0)
        }
        
        self.drawView.delegate = self
        self.TimeCount = 60
        self.drawView.lineColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        //309A09
        self.drawView.lineWidth = 10.0

        self.drawView.drawTool = ACEDrawingToolTypePen
        
        print(self.Busyu)
        self.OdaiText.text = self.Busyu
        self.OdaiText2.text = "(\(self.Busyu2))"
        if(RankNumber == 1){
            self.RankTitle.text = "初級"
            self.ConditionLabel.text = "・なし"
            self.ConditionLabel2.text = ""
        }
        else if(self.RankNumber == 2){
            self.RankTitle.text = "中級"
            self.ConditionLabel.text = "・3画以上"
            self.ConditionLabel2.text = "・10画以内"
        }
        else{
            self.RankTitle.text = "上級"
            self.ConditionLabel.text = "・11画以上"
            self.ConditionLabel2.text = ""
        }
        
        self.CountTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            self.TimeCount -= 1
            self.CountNumber.text = "\(self.TimeCount)"
            
            if(self.TimeCount == 0){
                
                
                self.TimeOut = false
                self.CountNumber.text = "0"
                
                self.performSegue(withIdentifier: "TimeUp", sender: nil)
                self.TimeCount = 60
            }
            
        }
    }
    func updateHP(Gage: UIView,Back: UIView,Hp: Float,MaxHP: Float) {

        let GageNum = CGFloat(Hp/MaxHP)
        let GageWidth = (Back.frame.width - 20) * GageNum
        Gage.frame.size.width = GageWidth
        
        

    }
    
    func drawingView(_ drawingView: ACEDrawingView!, didEndDrawUsing tool: ACEDrawingTool!) {
        self.DrawCount += 1
        }
    
    func SaveImage() -> UIImage {
        let ViewRender = UIGraphicsImageRenderer(bounds: self.drawView.bounds)

        let Img = ViewRender.image { context in
            self.drawView.layer.render(in: context.cgContext)
        }
        return Img
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TimeUp" {
            
            
            if let TimeUp = segue.destination as? TimeUpController {
                
                TimeUp.self.RankNumber = self.RankNumber
                TimeUp.self.BattlepPlayer = self.BattlepPlayer
                
                TimeUp.self.Hp1 = self.Hp1
                TimeUp.self.Hp2 = self.Hp2
                TimeUp.self.Hp1GageNumber = self.Hp1GageNumber
                TimeUp.self.Hp2GageNumber = self.Hp2GageNumber
                TimeUp.self.Player1Image = self.Player1Image
                TimeUp.self.Player2Image = self.Player2Image
                TimeUp.self.Busyu = self.Busyu
                TimeUp.self.Busyu2 = self.Busyu2
                TimeUp.self.Hp1DownNumber = self.Hp1DownNumber
                TimeUp.self.Hp2DownNumber = self.Hp2DownNumber
            }
        }
        if segue.identifier == "goResult"{
            if let GoResult = segue.destination as? GoResultController {
                
                GoResult.self.RankNumber = self.RankNumber
                GoResult.self.BattlepPlayer = self.BattlepPlayer
                
                GoResult.self.Hp1 = self.Hp1
                GoResult.self.Hp2 = self.Hp2
                GoResult.self.Hp1GageNumber = self.Hp1GageNumber
                GoResult.self.Hp2GageNumber = self.Hp2GageNumber
                GoResult.self.Busyu = self.Busyu
                GoResult.self.Busyu2 = self.Busyu2
                GoResult.self.Player1Image = self.Player1Image
                GoResult.self.Player2Image = self.Player2Image
                GoResult.self.Hp1DownNumber = self.Hp1DownNumber
                GoResult.self.Hp2DownNumber = self.Hp2DownNumber
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.CountTimer?.invalidate()
        self.CountTimer = nil
    }

    @IBAction func OkBtn(_ sender: Any) {
        self.CountTimer?.invalidate()
        self.CountTimer = nil
        let Img = SaveImage()

        if(self.BattlepPlayer == 1){
            self.Player1Image = self.SaveImage()
            
            
            guard let image = self.Player1Image else {
                print("Image is not exist")
                return
            }

            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Image data conversion failed")
                return
            }

            let base64Image = imageData.base64EncodedString()

            let parameters: [String: Any] = [
                "contents": [
                    [
                        "role": "user",
                        "parts": [
                            [
                                "text": """
                                あなたは手書き漢字認識AIです。

                                画像に書かれている漢字を1文字認識してください。

                                今回の判定対象となる部首・構成要素は「\(self.Busyu)」です。

                                ## 判定ルール

                                1. 画像から手書きされている漢字を1文字認識してください。
                                2. 認識した漢字の字形を分析してください。
                                3. 認識した漢字の中に、指定された「\(self.Busyu)」が
                                   部首または構成要素として含まれている場合は true にしてください。
                                4. 指定された部首・構成要素が漢字の一部として使用されていない場合は false にしてください。
                                5. 部首が漢字のどの位置にあるかは問いません。
                                   上、下、左、右、内側など、どこにあっても判定してください。
                                6. 「\(self.Busyu)」と完全に同じ意味の部首名である必要はありません。
                                   実際の漢字の字形の構成要素として「\(self.Busyu)」が含まれているかを判定してください。
                                7. 認識した文字が実在する漢字でない場合は false にしてください。


                                ## 重要

                                例えば今回の部首が「宀」の場合、
                                「穴」のように漢字の中に「宀」の字形を含む漢字は true としてください。
                                また、
                                「字」「安」「空」「家」「室」「究」
                                などのような、「宀」を含む漢字も true としてください。
                                ## 出力形式
                                必ず以下のJSON形式のみで回答してください。
                                JSON以外の文章は禁止です。
                                マークダウンも禁止です。
                                
                                ## 出力例
                                {
                                    "RecognizedText": "認識した文字",
                                    "IsRadical": true
                                }
                            """
                            ],
                            [
                                "inlineData": [
                                    "mimeType": "image/jpeg",
                                    "data": base64Image
                                ]
                            ]
                        ]
                    ]
                ]
            ]
            

            GeminiUtil.shared.requestGemini(params: parameters)
            
        }else{
            self.Player2Image = self.SaveImage()
            
            guard let image = self.Player2Image else {
                print("Image is not exist")
                return
            }

            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Image data conversion failed")
                return
            }

            let base64Image = imageData.base64EncodedString()

            let parameters: [String: Any] = [
                "contents": [
                    [
                        "role": "user",
                        "parts": [
                            [
                                "text": """
                                あなたは手書き漢字認識AIです。

                                画像に書かれている漢字を1文字認識してください。

                                今回の判定対象となる部首・構成要素は「\(self.Busyu)」です。

                                ## 判定ルール

                                1. 画像から手書きされている漢字を1文字認識してください。
                                2. 認識した漢字の字形を分析してください。
                                3. 認識した漢字の中に、指定された「\(self.Busyu)」が
                                   部首または構成要素として含まれている場合は true にしてください。
                                4. 指定された部首・構成要素が漢字の一部として使用されていない場合は false にしてください。
                                5. 部首が漢字のどの位置にあるかは問いません。
                                   上、下、左、右、内側など、どこにあっても判定してください。
                                6. 「\(self.Busyu)」と完全に同じ意味の部首名である必要はありません。
                                   実際の漢字の字形の構成要素として「\(self.Busyu)」が含まれているかを判定してください。
                                7. 認識した文字が実在する漢字でない場合は false にしてください。


                                ## 重要

                                例えば今回の部首が「宀」の場合、
                                「穴」のように漢字の中に「宀」の字形を含む漢字は true としてください。
                                また、
                                「字」「安」「空」「家」「室」「究」
                                などのような、「宀」を含む漢字も true としてください。
                                ## 出力形式
                                必ず以下のJSON形式のみで回答してください。
                                JSON以外の文章は禁止です。
                                マークダウンも禁止です。
                                
                                ## 出力例
                                {
                                    "RecognizedText": "認識した文字",
                                    "IsRadical": true
                                }
                            """
                            ],
                            [
                                "inlineData": [
                                    "mimeType": "image/jpeg",
                                    "data": base64Image
                                ]
                            ]
                        ]
                    ]
                ]
            ]

            GeminiUtil.shared.requestGemini(params: parameters)
            
        }
    }
    func didReceiveGeneratedJson(_ json: JSON)
    {
        guard let geminiText = json["candidates"][0]["content"]["parts"][0]["text"].string
            else {
                print("Geminiの回答を取得できません")
                print(json)

                return
            }
        var text = GeminiUtil.shared.convertJSONSymbols(input: json["candidates"][0]["content"]["parts"][0]["text"].stringValue)
        text = text.replacingOccurrences(of: "```json", with: "")
        text = text.replacingOccurrences(of: "```", with: "")
        
        print("Geminiの回答: \(text)")

        guard let data = text.data(using: .utf8) else {
            return
        }
        
        let resultJson = JSON(data)
        

        let RecognizedText = resultJson["RecognizedText"].stringValue
        let IsRadical = resultJson["IsRadical"].boolValue

        print("認識された文字: \(RecognizedText)")
        print("判定: \(IsRadical)")

        
        print(json["keyword"].stringValue)
        
        DispatchQueue.main.async {
            
            print(self.RankNumber)
            print(self.DrawCount)
            if IsRadical{
                
                if(self.RankNumber == 2){
                    
                    if(self.DrawCount < 3 || self.DrawCount > 10){
                        self.NotRecognition()
                        
                    }else{
                        self.YesRecognition()
                    }

                }
                else if(self.RankNumber == 3){
                    if(self.DrawCount < 11){
                        self.NotRecognition()
                    }else{
                        self.YesRecognition()
                    }
                    
                }else{
                    self.YesRecognition()
                }

                
            }else{
                self.NotRecognition()
            }
            

        }
        
    }
    func YesRecognition()
    {
        self.ShowYes()
        self.TimeOut = false
        if(self.BattlepPlayer == 1){
            self.Hp1DownNumber = Float(self.DrawCount)
            print(self.Hp1DownNumber)
            if let goStart = self.navigationController?
                .viewControllers
                .dropLast()
                .last as? StartController {
                
                goStart.self.Player1Image = self.Player1Image
                goStart.self.Hp1 = self.Hp1
                goStart.self.Hp2 = self.Hp2
                goStart.self.Hp1GageNumber = self.Hp1GageNumber
                goStart.self.Hp2GageNumber = self.Hp2GageNumber
                goStart.self.randomBusyu = self.Busyu
                goStart.self.randomBusyu2 = self.Busyu2
                goStart.self.Hp1DownNumber = self.Hp1DownNumber
                goStart.self.Hp2DownNumber = self.Hp2DownNumber
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }else{
            self.Hp2DownNumber = Float(self.DrawCount)
            print(self.Hp2DownNumber)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                self.performSegue(withIdentifier: "goResult", sender: nil)
            }
            
        }
    }
    func NotRecognition()
    {
        self.ShowNo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            self.drawView.clear()
        }
        
        
        self.DrawCount = 0
        
        self.CountTimer = Timer.scheduledTimer(withTimeInterval: 1.0,repeats: true) {_ in

        self.TimeCount -= 1

        self.CountNumber.text = "\(self.TimeCount)"
        if(self.TimeCount == 0){
                
                
            self.TimeOut = false
            self.CountNumber.text = "0"
                
            self.performSegue(withIdentifier: "TimeUp", sender: nil)
            self.TimeCount = 60
        }
    }
    }
    func ShowYes() {

        self.YesOrNotImg.image = UIImage(named: "YesMark")
        self.YesOrNotImg.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            self.YesOrNotImg.isHidden = true
        }
    }
    func ShowNo() {

        self.YesOrNotImg.image = UIImage(named: "NoMark")
        self.YesOrNotImg.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            self.YesOrNotImg.isHidden = true
        }
    }
}
