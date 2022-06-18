//
//  input.swift
//  Baekjoon_1000
//
//  Created by Sean Kim on 2022/03/25.
//

import Foundation

class InputAll {
    
    // 들어오는 줄이 2개면 2번 호출 해야함
    
    // map
    
    func keyReadLine(inputString : String?) -> [String]{
        guard let inputString = inputString else { return ["ERROR"] }
        let outputArray = inputString.components(separatedBy: " ")
        return outputArray
    }
    
    func keyReadLine(inputString: String?) -> [Int]{
        guard let inputString = inputString else { return [] }
        let convertBefore = inputString.components(separatedBy: " ")
        var outputArray : [Int] = []
        
        for i in 0 ..< convertBefore.count {
            guard let checkConvertInt = Int(convertBefore[i]) else { return [] }
            outputArray.append(checkConvertInt)            
        }
        return outputArray
    }
    
}

