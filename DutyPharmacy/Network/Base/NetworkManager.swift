//
//  NetworkManager.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    static let instance = NetworkManager()
    
    public func fetch<T:Codable> (endpoint: Endpoint,
                                  responseModel: T.Type,
                                  completed: @escaping (Swift.Result<T,NetworkError>) -> Void)
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            completed(.failure(.invalidURL))
            return
        }
        
        AF.request(url, method: endpoint.method, parameters: endpoint.param, encoding: URLEncoding(destination: .queryString), headers: endpoint.header)
            .validate()
            .responseData { response in
                
                if let _ =  response.error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                else if response.response?.statusCode != 200 {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard response.data != nil else {
                    completed(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    print(String(data: response.data!, encoding: .utf8)!)
                    let decodedResponse = try decoder.decode(T.self, from: response.data!)
                    completed(.success(decodedResponse))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
    }
}
