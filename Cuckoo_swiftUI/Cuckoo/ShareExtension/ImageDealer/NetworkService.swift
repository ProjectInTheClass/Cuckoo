//
//  dealingImage.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI
import Combine

enum NetworkMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

struct RequestBuilder {
    let url: URL?
    let method: NetworkMethod = .get
    let body: Data?
    let headers: [String: String]?

    func create() -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        if let body = body {
            request.httpBody = body
        }
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
}

final class NetworkService {

    enum NetworkError: Error {
        case invalidRequest
        case unknownError(message: String)
    }

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidRequest
                }
                return data
            }
            .mapError { error -> NetworkError in
                .unknownError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

    deinit {
        session.invalidateAndCancel()
    }
}
