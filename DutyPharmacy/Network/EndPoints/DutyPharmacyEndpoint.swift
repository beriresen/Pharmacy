//
//  DutyPharmacyEndpoint.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import Alamofire

enum DutyPharmacyEndpoint {
    case dutyPharmacy(city:String)
}

extension DutyPharmacyEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .dutyPharmacy:
            return "/apiv2/pharmacy"

        }
    }
    var method: HTTPMethod {
        switch self {
        case .dutyPharmacy:
            return .get
        }
    }
    var param: [String : Any]? {
        switch self {
        case .dutyPharmacy(let city):
            return ["city": city]

        }
    }
    var header: HTTPHeaders {
      //  let accessToken = "xxxxx"
        switch self {
        case .dutyPharmacy:
            return [
                "Content-Type":"application/json",
                "Authorization":"Bearer SECRET_API_KEY"
              //  "Authorization": "Bearer API KEY \(accessToken)"
            ]
        }
    }
    var body: [String: String]? {
        switch self {
        case .dutyPharmacy:
            return nil
        }
    }
}
