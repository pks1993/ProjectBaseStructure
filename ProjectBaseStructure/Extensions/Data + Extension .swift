//
//  Data + Extension .swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import Foundation
import SwiftyJSON

extension Data {
    
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
    
    func singleDecode<T>(key : ApiConfig.FilterKeys, type : T.Type) -> T? {
        let json = JSON(self)
        return json[key.getString()] as? T
    }
    
    func toJsonString() -> String? {
        let json = JSON(self)
        let jsonString = json.rawString()
        return jsonString
    }
    
    func filterByKey(keys : ApiConfig.FilterKeys...) -> Data {
        
        var json = JSON(self)
        
        keys.forEach { (key) in
            json = json[key.getString()]
        }
        
        let jsonString = json.rawString()
        let data = Data(jsonString!.utf8)
        return data
    }

}
