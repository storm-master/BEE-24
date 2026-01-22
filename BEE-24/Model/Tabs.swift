import SwiftUI

enum Tabs: CaseIterable {
    case articles
    case exercises
    case lessons
    case progress
    
    var title: String {
        switch self {
        case .articles: return "Archery\nBasics"
        case .exercises: return "Exercises"
        case .lessons: return "Rhythm\nLessons"
        case .progress: return "Progress\nand notes"
        }
    }
    
    var image: ImageResource {
        switch self {
        case .articles: return .tab1
        case .exercises: return .tab2
        case .lessons: return .tab3
        case .progress: return .tab4
        }
    }
    
    var imageOn: ImageResource {
        switch self {
        case .articles: return .tab1On
        case .exercises: return .tab2On
        case .lessons: return .tab3On
        case .progress: return .tab4On
        }
    }
}

