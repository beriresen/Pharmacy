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
      //  let accessToken = "jNl48pxho7lJvPw2WWizC3MzxYh5VMtu17dLcyeGcjy5LliVT120rkd0g3Lh"
        switch self {
        case .dutyPharmacy:
            return [
                "Content-Type":"application/json",
                "Authorization":"Bearer ERnAkPxWaV5VcHPJl4gPbR9D1PRB6QvDzS6GUBWQeqm0nYpD42XO9EKk1SRb"
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
