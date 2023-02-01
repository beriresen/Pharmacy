//
//  DistrictStruct.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import Foundation

struct District: Codable {
    var success: Bool?
    var results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    var text: String?
}
