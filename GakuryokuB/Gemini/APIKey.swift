//
//  APIKey.swift
//  RealtimeS2T
//
//  Created by ISHIGO Yusuke on 2025/05/07.
//

import Foundation

enum APIKey
{
	static var `default`: String
	{
		let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
		let plist = NSDictionary(contentsOfFile: filePath!)
		
		let val = plist?.object(forKey: "API_KEY") as! String
		
		return val
	}
}
