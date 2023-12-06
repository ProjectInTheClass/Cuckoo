////
////  ImageDealer.swift
////  ShareExtension
////
////  Created by 유철민 on 12/6/23.
////
//
//import Foundation
//import SwiftUI
//import Combine
//
//class URLImageLoader: ObservableObject {
//    @Published var image = UIImage(named: "logo")
//
//    private let network = NetworkService(session: URLSession.shared)
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetch(urlString: String?) {
//        guard let urlString = urlString else { return }
//        let url = URL(string: urlString)
//        let urlRequest = RequestBuilder(url: url,
//                                        body: nil,
//                                        headers: nil).create()
//
//        guard let request = urlRequest else { return }
//        network.request(request: request)
//            .sink { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .finished:
//                    print("success")
//                }
//            } receiveValue: { [weak self] data in
//                DispatchQueue.main.async {
//                    self?.image = UIImage(data: data)
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    deinit {
//        cancellables.forEach { $0.cancel() }
//    }
//}
//
//
//struct URLImage: View {
//    @StateObject private var imageLoader = URLImageLoader()
//
//    private let urlString: String?
//
//    init(urlString: String?) {
//        self.urlString = urlString
//    }
//
//    var body: some View {
//        content
//            .onAppear {
//                imageLoader.fetch(urlString: urlString)
//            }
//    }
//
//    private var content: some View {
//        Group {
//            if let image = imageLoader.image {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//
//            } else {
//                ActivityIndicatorView()
//                    .padding()
//            }
//        }
//    }
//}
