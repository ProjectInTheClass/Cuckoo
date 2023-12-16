//
//  TagViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/16/23.
//

import Foundation


class TagViewModel: ObservableObject {
    static let shared = TagViewModel()
    @Published var tags: [Tag] = []
//    private let provider = MoyaProvider<TagAPI>()

    func loadTagsForMemo(memoId: Int) {
//        provider.request(.loadTag(type: "memo", identifier: String(memoId))) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    // 서버로부터 받은 응답을 파싱하여 태그 배열에 저장
//                    let tagResponse = try JSONDecoder().decode(LoadTagResponse.self, from: response.data)
//                    DispatchQueue.main.async {
//                        self.tags = tagResponse.map { Tag(id: $0.id, name: $0.name, color: $0.color, memoCount: $0.memoCount) }
//                    }
//                } catch {
//                    print("Error decoding tags: \(error)")
//                }
//            case .failure(let error):
//                print("Error loading tags: \(error)")
//            }
//        }
    }
}
