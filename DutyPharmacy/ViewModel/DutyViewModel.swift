//
//  DutyViewModel.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import Foundation
import Alamofire

class DutyViewModel {
    var dutyPharmacy = Observable<Pharmacy>()
    var isLoading = Observable<Bool>()
    var alertItem = Observable<AlertItem>()
    
    func getDutyPharmacy(city: String){
        isLoading.value = true
        
        NetworkManager.instance.fetch(endpoint: DutyPharmacyEndpoint.dutyPharmacy(city: city), responseModel: Pharmacy.self){ [self] result in
            
            DispatchQueue.main.async { [self] in
                isLoading.value = false
                
                switch result {
                case .success(let result):
                    self.dutyPharmacy.value = result
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem.value = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem.value = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem.value = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem.value = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
