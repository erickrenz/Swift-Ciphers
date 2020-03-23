# Ciphers
Basic Cryptography Ciphers written in Swift that work with many different languages and Emojis!</br>

## Vigenère Cipher
This Vigenère Cipher code works well with many different languages and their characters, as well as most Emojis. Below you can see how to use this cipher to encrypt or decrypt messages.

#### I/O Format
```swift
// Input:

let text = "This Vigenère Cipher can encrypt and decrypt in mâñÿ dîfférëńt łåńgūàgęš and Emojis!😃"
let key = "Vigenère Cipher - Swift🚀"

let cipher = Vigenere(key: key)!
let encoded = cipher.encrypt(text)!
let decoded = cipher.decrypt(encoded)!

// Output:

print("Key: \(key)")
print("Plain Text: \(text)")
print("Cipher Text: \(encoded)")
print("Decoded: \(decoded)")

/*
Key: Vigenère Cipher - Swift🚀
Plain Text: This Vigenère Cipher can encrypt and decrypt in mâñÿ dîfférëńt łåńgūàgęš and Emojis!😃
Cipher Text: ±°¸nĞ»¬eıÂ­ei}hÉi©µ🛎V®µ¨ÀŁÂ¹ ·´h©·cy£Ëi¯Â🚀£īĸńnĬŀ«fČ»Ļƌ¹rłòńǂĩ­ŭçVªµ©nč¿´j¼q🙋
Decoded: This Vigenère Cipher can encrypt and decrypt in mâñÿ dîfférëńt łåńgūàgęš and Emojis!😃
*/
```
