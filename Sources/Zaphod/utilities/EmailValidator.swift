//
//  File.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import Foundation

class EmailTextFieldValidator {
    func validate(input: String?) -> String? {
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
