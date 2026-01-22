import Foundation

struct ProgressModel: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var result: Int
    var goal: Int
    var notes: String
    var date: Date
}

