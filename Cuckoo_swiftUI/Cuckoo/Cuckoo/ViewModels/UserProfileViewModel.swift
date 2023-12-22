import SwiftUI
import CoreData

class UserProfileViewModel: ObservableObject {
    static let shared = UserProfileViewModel()
    @Published var profileImage: UIImage?
    @Published var username: String
    @Published var multiplier: Int
    @Published var reminderPeriod: Int
    var isRegistered = false

    init() {
        username = ""
        profileImage = nil
        multiplier = 1
        reminderPeriod = 1
        fetchUserData()
    }
    
    private func fetchUserData() {
        if let savedUsername = UserDefaults.standard.string(forKey: "username") {
            self.username = savedUsername
        }
        
        if let profileImagePath = UserDefaults.standard.string(forKey: "profileImagePath") {
            if let profileImage = UIImage(contentsOfFile: profileImagePath) {
                self.profileImage = profileImage
            }
        }
    }
    
    func setMultiplier(_ selectedMultiplier:Int) {
        UserDefaults.standard.set(selectedMultiplier, forKey: "multiplier")
    }
    
    func setTerm(_ selectedReminderPeriod: Int) {
        UserDefaults.standard.set(selectedReminderPeriod, forKey: "reminderPeriod")
    }
    
    func updateUsername(username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
        self.username = username
    }
    
    func getUsername() -> String {
        if let username = UserDefaults.standard.string(forKey: "username") {
            return username
        }
        
        return self.username
    }
    
    func resetRegistration() {
        UserDefaults.standard.set(false, forKey: "isRegistered")
    }

    func createUser(username: String, profileImagePath: String?) {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(true, forKey: "isRegistered")
        
        print("ADDED")
        
        if let imagePath = profileImagePath {
            UserDefaults.standard.set(imagePath, forKey: "profileImagePath")
        }
    }
    
    func setProfileImage(_ image: UIImage) {
        self.profileImage = image
    }
}
