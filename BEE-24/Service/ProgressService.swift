import Foundation

class ProgressService {
    static let shared = ProgressService()
    
    private let key = "progress_storage"
    
    private init() {}
    
    func add(_ progress: ProgressModel) {
        var progressList = getAll()
        progressList.append(progress)
        save(progressList)
    }
    
    func getAll() -> [ProgressModel] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let progressList = try? JSONDecoder().decode([ProgressModel].self, from: data) else {
            return []
        }
        return progressList
    }
    
    func update(_ progress: ProgressModel) {
        var progressList = getAll()
        if let index = progressList.firstIndex(where: { $0.id == progress.id }) {
            progressList[index] = progress
            save(progressList)
        }
    }
    
    func delete(_ progress: ProgressModel) {
        var progressList = getAll()
        progressList.removeAll { $0.id == progress.id }
        save(progressList)
    }
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    private func save(_ progressList: [ProgressModel]) {
        if let data = try? JSONEncoder().encode(progressList) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

