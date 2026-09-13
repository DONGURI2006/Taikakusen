//
//  GeminiUtil.swift
//  GeminiSample
//
//  Created by ISHIGO Yusuke on 2025/08/13.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol GeminiUtilDelegate: AnyObject
{
	func didReceiveGeneratedJson(_ json: JSON)
}

class GeminiUtil: NSObject
{
	private override init()
	{
	}

	static let shared = GeminiUtil()
	
	var session: Session?
	
	weak var delegate: GeminiUtilDelegate?

	let modelName = "gemini-3.5-flash-lite"
	
	func requestGemini(params: [String: Any])
	{
		let apiKey = APIKey.default
		let url = "https://generativelanguage.googleapis.com/v1beta/models/\(self.modelName):generateContent?key=\(apiKey)"
		
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 10
		configuration.timeoutIntervalForResource = 10
		
		self.session = Session(configuration: configuration)
		
		self.session?.request(
			url,
			method: .post,
			parameters: params,
			encoding: JSONEncoding.default
		)
		.responseJSON { response in
			
			print(response.data)
			
			if let data = response.data
			{
				let json = JSON(data)

				self.delegate?.didReceiveGeneratedJson(json)
			}
		}
	}
	
	func convertJSONSymbols(input: String) -> String {
		var output = input

		// 全角記号を対応する半角記号に置換
		let replacements = [
			"“": "\"",
			"”": "\"",
			"：": ":",
			"，": ",",
			"｛": "{",
			"｝": "}",
			"［": "[",
			"］": "]"
		]

		for (fullWidth, halfWidth) in replacements {
			output = output.replacingOccurrences(of: fullWidth, with: halfWidth)
		}

		return output
	}
}
