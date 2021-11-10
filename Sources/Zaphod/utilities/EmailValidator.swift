//
//  File.swift
//  
//
//  https://multithreaded.stitchfix.com/blog/2016/11/02/email-validation-swift/
//

import Foundation

class EmailTextFieldValidator {
    static func validate(input: String?) -> String? {
        guard let trimmedText = input?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        }

        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return nil
        }

        let range = NSMakeRange(0, NSString(string: trimmedText).length)
        let allMatches = dataDetector.matches(in: trimmedText,
                                              options: [],
                                              range: range)

        if allMatches.count == 1,
            allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return trimmedText
        }
        return nil
    }
}
