//
//  VigenèreCipher.swift
//  Crypto
//
//  Created by Eric Krenz on 3/17/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import UIKit

// Sets Alphalbet with smallest and largest UInt32 characters
public let largestScalar: UInt32 = UInt32("🛹")
public let smallestScalar: UInt32 = UInt32(" ")

// Converts a given string into its Unicode Scalar Components
public func convertToUnicodeScalars(str: String) -> [UInt32] {
    // Creates Array for Scalar Values
    var scalars = [UInt32]()
    
    for scalar in str.unicodeScalars {
        let val = scalar.value
        
        // Skips over characters out of the scalar range
        guard val >= smallestScalar && val <= largestScalar else {
            continue
        }
        
        // Adds scalars to array
        scalars.append(val)
    }
    
    // Returns array
    return scalars
}

// Vigenère Cipher Code
public struct Vigenere {
    // Creates Key Scalars Array
    private let keyScalars: [UInt32]
    // Creates Variable for Alphalbet Size
    private let sizeAlphabet: UInt32
    
    // Initalize Vigenere Class
    public init?(key: String) {
        self.sizeAlphabet = (largestScalar - smallestScalar) + 1
        let scalars = convertToUnicodeScalars(str: key)
        
        // Skips if Scalars Array is Empty
        guard !scalars.isEmpty else {
            return nil
        }
        
        self.keyScalars = scalars
    }
    
    // Code to Encrypt a Message
    // Hard-to-Read Cipher Text -> Easy-to-Read Plain Text
    public func decrypt(_ str: String) -> String? {
        // Creates array for input message to be decrypted
        let encrypted_message = convertToUnicodeScalars(str: str)
        // Creates empty string for output of decrypted message
        var decrypted_message = ""
        
        // Loop verifies that no unknown characters are being used
        if encrypted_message.isEmpty {
            return nil
        }
        else {
            for (i, c) in encrypted_message.enumerated() where c >= smallestScalar && c <= largestScalar {
                guard let char = UnicodeScalar((c &+ sizeAlphabet &- keyScalars[i % keyScalars.count]) % sizeAlphabet &+ smallestScalar) else {
                        return nil
                }
                
                // Adds Character to Decrypted String
                decrypted_message += String(char)
            }
            
            // Returns Decrypted Message
            return decrypted_message
        }
    }
    
    // Code to Encrypt a Message
    // Easy-to-Read Plain Text -> Hard-to-Read Cipher Text
    public func encrypt(_ str: String) -> String? {
        // Creates array for input message to be encrypted
        let decrypted_message = convertToUnicodeScalars(str: str)
        // Creates empty string for output of encrypted message
        var encrypted_message = ""
        
        // Loop verifies that no unknown characters are being used
        if decrypted_message.isEmpty {
            return nil
        }
        else {
            for (i, c) in decrypted_message.enumerated() where c >= smallestScalar && c <= largestScalar {
                guard let char = UnicodeScalar((c &+ keyScalars[i % keyScalars.count] &- 2 &* smallestScalar) % sizeAlphabet &+ smallestScalar) else {
                        return nil
                }
                
                // Adds Character to Decrypted String
                encrypted_message += String(char)
            }
            
            // Returns Encrypted Message
            return encrypted_message
        }
    }
}

// Basic I/O Formatting
let text = "This Vigenère Cipher can encrypt and decrypt in mâñÿ dîfférëńt łåńgūàgęš and Emojis!😃"
let key = "Vigenère Cipher - Swift🚀"

let cipher = Vigenere(key: key)!
let encoded = cipher.encrypt(text)!
let decoded = cipher.decrypt(encoded)!

print("Key: \(key)")
print("Plain Text: \(text)")
print("Cipher Text: \(encoded)")
print("Decoded: \(decoded)")
