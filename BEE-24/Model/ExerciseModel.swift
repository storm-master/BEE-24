import Foundation

struct ExerciseModel: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var notes: String
    var date: Date
    var targetDistance: Int
    var repetitions: Int
}

