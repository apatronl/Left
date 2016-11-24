//
//  String.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

extension String {
    
    func verifyRecipeName() -> String {
        var verifiedString = self
        verifiedString = verifiedString.replacingOccurrences(of: "&amp;", with: "&")
        verifiedString = verifiedString.replacingOccurrences(of: "&#8217;", with: "'")
        verifiedString = verifiedString.replacingOccurrences(of: "&#8482;", with: "®")
        verifiedString = verifiedString.replacingOccurrences(of: "&nbsp;", with: " ")
        
        return verifiedString
    }
    
    func urlToImg(completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let url = NSURL(string: self)
            if let data = NSData(contentsOf: url! as URL) {
                if let image = UIImage(data: data as Data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
}
