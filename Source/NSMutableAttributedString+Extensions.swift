//
//  NSMutableAttributedString+Extensions.swift
//
//  Copyright (c) 2017 Alex Givens (http://alexgivens.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public extension NSMutableAttributedString {
    
    /**
     Modifies this instance of the string to remove characters from a given character set from
     the beginning and end of the string.
     See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
     - Parameters:
     - charSet: The character set with which to remove characters.
     */
    
    func stringByTrimmingCharactersInSet(_ set: CharacterSet) {
        
        let string = self.string as NSString
        var range = string.rangeOfCharacter(from: set)
        
        // Trim leading characters from character set.
        while range.length != 0 && range.location == 0 && !self.string.isEmpty {
            replaceCharacters(in: range, with: "")
            range = string.rangeOfCharacter(from: set)
        }
        
        // Trim trailing characters from character set.
        range = string.rangeOfCharacter(from: set, options: .backwards)
        while range.length != 0 && NSMaxRange(range) == length && !self.string.isEmpty {
            replaceCharacters(in: range, with: "")
            range = string.rangeOfCharacter(from: set, options: .backwards)
        }
    }
    
}
