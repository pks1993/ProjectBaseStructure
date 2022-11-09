//
//  BaseResponse.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import Foundation

struct BaseResponse : Codable {
    let success : Bool?
    let message : String?
    
    
    enum CodingKeys : String , CodingKey {
        case success
        case message
    }
}
