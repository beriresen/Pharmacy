//
//  PharmacyStruct.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import Foundation

//// MARK: - Welcome
//struct Pharmacy: Codable {
//    var success: Bool?
//    var result: [PharmacyList]?
//
//    enum CodingKeys: String, CodingKey {
//        case result = "result"
//    }
//}
//
//// MARK: - Result
//struct PharmacyList: Codable {
//    var name, dist, address, phone: String?
//    var loc: String?
//}

// MARK: - Welcome
struct Pharmacy: Codable {
    var status, message: String?
    var rowCount: Int? 
    var data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    var eczaneAdi, adresi, semt: String?
    var yolTarifi: String?
    var telefon, telefon2: String?
    var sehir: String?
    var ilce: String?
    var latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case eczaneAdi = "EczaneAdi"
        case adresi = "Adresi"
        case semt = "Semt"
        case yolTarifi = "YolTarifi"
        case telefon = "Telefon"
        case telefon2 = "Telefon2"
        case sehir = "Sehir"
        case ilce, latitude, longitude
    }
}
