//
//  Date+Extensions.swift
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

extension Date {
    
    public var timeAgo: String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as NSCalendar).components([.minute , .hour , .day , .weekOfYear , .month , .year , .second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if components.year! >= 1 || components.month! >= 8 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLL d, yyyy"
            return dateFormatter.string(from: self)
        } else if components.month! >= 1 || components.weekOfYear! >= 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLL d"
            return dateFormatter.string(from: self)
        } else if components.day! >= 1 {
            return "\(components.day!)d"
        } else if components.hour! >= 1 {
            return "\(components.hour!)h"
        } else if components.minute! >= 2 {
            return "\(components.minute!)m"
        } else if components.second! >= 30 {
            return "\(components.second!)s"
        } else {
            return "now"
        }
    }
    
}
