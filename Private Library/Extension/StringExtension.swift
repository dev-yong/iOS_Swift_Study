//
//  StringExtension.swift
//  
//
//  Created by 이광용 on 2017. 12. 11..
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func isNilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
