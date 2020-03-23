//
//  VigenèreCipher.swift
//  Crypto
//
//  Created by Eric Krenz on 3/17/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import UIKit

public let largestScalar: UInt32 = UInt32("🛹") // 🏴󠁧󠁢󠁷󠁬󠁳󠁿
public let smallestScalar: UInt32 = UInt32(" ")

public func convertToUnicodeScalars(str: String) -> [UInt32] {
    var scalars = [UInt32]()
    
    for scalar in str.unicodeScalars {
        let val = scalar.value
        
        guard val >= smallestScalar && val <= largestScalar else {
            continue
        }
        
        scalars.append(val)
    }
    
    return scalars
}

public struct Vigenere {
    private let keyScalars: [UInt32]
    private let sizeAlphabet: UInt32
    
    public init?(key: String) {
        self.sizeAlphabet = (largestScalar - smallestScalar) + 1
        let scalars = convertToUnicodeScalars(str: key)
        
        guard !scalars.isEmpty else {
            return nil
        }
        
        self.keyScalars = scalars
    }
    
    public func decrypt(_ str: String) -> String? {
        let encrypted_message = convertToUnicodeScalars(str: str)
        var decrypted_message = ""
        
        if encrypted_message.isEmpty {
            return nil
        }
        else {
            for (i, c) in encrypted_message.enumerated() where c >= smallestScalar && c <= largestScalar {
                guard let char = UnicodeScalar((c &+ sizeAlphabet &- keyScalars[i % keyScalars.count]) % sizeAlphabet &+ smallestScalar) else {
                        return nil
                }
                
                decrypted_message += String(char)
            }
            
            return decrypted_message
        }
    }
    
    public func encrypt(_ str: String) -> String? {
        let decrypted_message = convertToUnicodeScalars(str: str)
        var encrypted_message = ""
        
        if decrypted_message.isEmpty {
            return nil
        }
        else {
            for (i, c) in decrypted_message.enumerated() where c >= smallestScalar && c <= largestScalar {
                guard let char = UnicodeScalar((c &+ keyScalars[i % keyScalars.count] &- 2 &* smallestScalar) % sizeAlphabet &+ smallestScalar) else {
                        return nil
                }
                
                encrypted_message += String(char)
            }
            
            return encrypted_message
        }
    }
}
