import Foundation

class ExerciseService {
    static let shared = ExerciseService()
    
    private let key = "exercises_storage"
    
    private init() {}
    
    func add(_ exercise: ExerciseModel) {
        var exercises = getAll()
        exercises.append(exercise)
        save(exercises)
    }
    
    func getAll() -> [ExerciseModel] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let exercises = try? JSONDecoder().decode([ExerciseModel].self, from: data) else {
            return []
        }
        return exercises
    }
    
    func update(_ exercise: ExerciseModel) {
        var exercises = getAll()
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
            save(exercises)
        }
    }
    
    func delete(_ exercise: ExerciseModel) {
        var exercises = getAll()
        exercises.removeAll { $0.id == exercise.id }
        save(exercises)
    }
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    private func save(_ exercises: [ExerciseModel]) {
        if let data = try? JSONEncoder().encode(exercises) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

