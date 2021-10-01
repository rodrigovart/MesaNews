//
//  Data.swift
//  Extensions
//
//  Created by MAC on 29/09/21.
//

import Foundation

extension Data {
    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
    
    func printFormatted(msg: String) -> Void{
        return print("\(msg) - \(self.prettyPrintedJSONString ?? "Data couldn't be printed")")
    }
    
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toPostString() -> String? {
        var postString = ""

        guard let jsonSerialization = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) else {
            print("Error in Serialization")
            return nil
        }

        guard let arrayString = jsonSerialization as? [String: Any]  else {
            print("Error in Array")
            return nil
        }
        
//        print(arrayString)
        
        arrayString.forEach{
//            print($0.key)
//            print($0.value)
            postString = postString + "\($0.key)=\($0.value)&"
        }
        
        return postString
    }
}

