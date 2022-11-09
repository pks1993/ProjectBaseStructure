//
//  ApiConfig.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import Foundation

class ApiConfig {
    enum FilterKeys : String {
        case success = "success"
        case message = "message"
        case data = "data"
        
        func getString() -> String {
            return self.rawValue
        }
    }
}
