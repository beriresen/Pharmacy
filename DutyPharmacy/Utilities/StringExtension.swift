//
//  StringExtension.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 23.01.2023.
//

import Foundation

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
