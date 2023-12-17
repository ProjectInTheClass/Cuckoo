//
//  MemoViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import Moya
import CoreData
import SwiftSoup

 
class MemoViewModel: ObservableObject {
    static let shared = MemoViewModel()//싱글톤 패턴으로 앱의 어느곳에서나 MemoViewModel.shared를 통해 같은 인스턴스에 접근할 수 있음
    let container: NSPersistentContainer = CoreDataManager.shared.persistentContainer

    @Published var memos: [MemoEntity] = []
    @Published var filteredMemos: [MemoEntity] = []  // This will hold the filtered list of memos

    @Published var selectedTags: Set<TagEntity> = []
    @Published var searchKeyword: String = ""

    
    init() {
        fetchMemo()
    }

    /// CORE DATA 관련 코드
    
    // 1. Core Data 에서 데이터 가져오기
    private func fetchMemo() {
        let request = NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
        
        do {
            self.memos = try container.viewContext.fetch(request)
            applyFilters()
        } catch {
            print("ERROR FETCHING CORE DATA: \(error)")
        }
    }
    
    
    // 2. Core Data 저장하기
    private func save() {
        do {
            try container.viewContext.save()
            fetchMemo()
        } catch {
            print("ERROR on SAVING: \(error)")
        }
    }
    
    func browseMemos() {
        self.memos = []
        self.fetchMemo()
        save()
    }
    
    // 3. ADD CORE DATA
    func addMemo(title: String, comment: String, url: URL?, notificationCycle: Int, notificationPreset: AlarmPresetEntity?, isPinned: Bool, tags: [TagEntity]) {
        guard let url = url else {
            // URL이 nil인 경우 처리
            return
        }
        
        getThumbURL(from: url) { [weak self] result in
            guard let self = self else { return }

            var thumbURLString: String?
            
            switch result {
            case .success(let thumbnailURL):
                print("Thumbnail URL: \(thumbnailURL)")
                thumbURLString = thumbnailURL
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                let newMemo = MemoEntity(context: self.container.viewContext)
                newMemo.title = title
                newMemo.comment = comment
                newMemo.url = URL(string: url.absoluteString)
                newMemo.thumbURL = thumbURLString != nil ? URL(string: thumbURLString!) : nil
                newMemo.noti_cycle = Int32(notificationCycle)
                newMemo.isPinned = isPinned

                // Preset 관련 관계 처리
                if let notificationPreset = notificationPreset {
                    newMemo.memo_preset = notificationPreset
                    notificationPreset.addToPreset_memo(newMemo)
                }
                
                // 태그 설정 및 연관 관계 처리
                for tag in tags {
                    newMemo.addToMemo_tag(tag)
                    tag.addToTag_memo(newMemo)
                }

                newMemo.created_at = Date()
                newMemo.updated_at = Date()
                
                self.save()
                self.fetchMemo()
            }
        }
    }
    
    
    func getThumbURL(from url: URL?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        // Check if the URL is a YouTube link
        if url.host?.contains("youtube.com") == true || url.host?.contains("youtu.be") == true {
            // Extract the YouTube video ID
            let videoID: String
            if url.host == "youtu.be" {
                videoID = url.lastPathComponent
            } else {
                videoID = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "v" })?.value ?? ""
            }

            // Construct the YouTube thumbnail URL
            if !videoID.isEmpty {
                let youtubeThumbnailURL = "https://img.youtube.com/vi/\(videoID)/hqdefault.jpg"
                completion(.success(youtubeThumbnailURL))
                return
            }
        }

        // For non-YouTube URLs, parse the HTML to find the og:image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let htmlString = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "Error parsing data", code: 0)))
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(htmlString)
                if let ogImage: Element = try doc.select("meta[property=og:image]").first() {
                    let thumbnailURL = try ogImage.attr("content")
                    if !thumbnailURL.isEmpty {
                        completion(.success(thumbnailURL))
                    } else {
                        completion(.failure(NSError(domain: "Empty content in og:image tag", code: 0)))
                    }
                } else {
                    completion(.failure(NSError(domain: "No og:image tag found on the page", code: 0)))
                }
            } catch Exception.Error(_, let message) {
                completion(.failure(NSError(domain: message, code: 0)))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    func editMemo(
        memoId: NSManagedObjectID,
        title: String?,
        comment: String?,
        url: URL? = nil,
        noti_cycle: Int?,
        noti_preset: AlarmPresetEntity?,
        tags: [TagEntity]?
    )
    {
        let context = container.viewContext
        if let memoToEdit = context.object(with: memoId) as? MemoEntity {
            if let title = title {
                memoToEdit.title = title
            }
            
            if let comment = comment {
                memoToEdit.comment = comment
            }
            
            if let noti_cycle = noti_cycle {
                memoToEdit.noti_cycle = Int32(noti_cycle)
            }
            
            if let noti_preset = noti_preset {
                memoToEdit.memo_preset = noti_preset
            }
            memoToEdit.updated_at = Date()
            // "전체" 태그를 제외하고 기존 태그 관계 제거
                    if let currentTags = memoToEdit.memo_tag as? Set<TagEntity> {
                        for tag in currentTags {
                            if tag.name != "전체" {
                                memoToEdit.removeFromMemo_tag(tag)
                                tag.removeFromTag_memo(memoToEdit)
                            }
                        }
                    }

                    // 새로운 태그 관계 추가 ("전체" 태그는 이미 추가되어 있음을 가정)
                    if let tags = tags {
                        for tag in tags {
                            if tag.name != "전체" {
                                memoToEdit.addToMemo_tag(tag)
                                tag.addToTag_memo(memoToEdit)
                            }
                        }
                    }
            
            if let url = url {
                // URL이 변경된 경우, 썸네일 URL도 업데이트
                getThumbURL(from: url) { result in
                    var thumbURLString: String?

                    switch result {
                    case .success(let thumbnailURL):
                        thumbURLString = thumbnailURL
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }

                    DispatchQueue.main.async {
                        memoToEdit.url = url
                        memoToEdit.thumbURL = thumbURLString != nil ? URL(string: thumbURLString!) : nil
                        self.save()
                        self.fetchMemo()
                    }
                }
            } else {
                save()
                self.fetchMemo()
            }
            
            
            fetchMemo()
        }
    }
        
        
    func deleteMemo(memoId: NSManagedObjectID) {
        let context = container.viewContext
        if let memoToDelete = context.object(with: memoId) as? MemoEntity {
            context.delete(memoToDelete)
            do {
                try context.save()
                fetchMemo() // 목록 업데이트
                print("Memo successfully deleted.")
            } catch {
                print("Error deleting memo: \(error)")
            }
        }
    }
    
    // 이하 Filtering 기능
    
    func updateFilterCriteria(selectedTags: Set<TagEntity>, searchKeyword: String) {
        self.selectedTags = selectedTags
        self.searchKeyword = searchKeyword
        applyFilters()
    }
    
    // Method to apply filters based on the current criteria
    private func applyFilters() {
        filteredMemos = memos.filter { memo in
            let memoTags = memo.memo_tag as? Set<TagEntity> ?? Set()
            let matchesTags = selectedTags.isEmpty || !memoTags.isDisjoint(with: selectedTags)
            
            if !searchKeyword.isEmpty {
                if let url = memo.url {
                    return matchesTags && (memo.title.contains(searchKeyword) || memo.comment.contains(searchKeyword) || url.absoluteString.contains(searchKeyword))
                } else {
                    return matchesTags && (memo.title.contains(searchKeyword) || memo.comment.contains(searchKeyword))
                }
            }
            
            return matchesTags
        }
        
    }
    


}
