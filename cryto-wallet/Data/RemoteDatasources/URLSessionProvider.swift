//
//  URLSessionProvider.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)

        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: @escaping (NetworkResponse<T>) -> ()) {
        DispatchQueue.main.async {
            guard error == nil else { return completion(.failure(.unknown)) }
            guard let response = response else { return completion(.failure(.noJSONData)) }

            switch response.statusCode {
            case 200...299:
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.unknown))
                    }
                } else {
                    completion(.failure(.noJSONData))
                }

            default:
                completion(.failure(.unknown))
            }
        }

    }
}
