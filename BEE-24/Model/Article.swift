import SwiftUI

enum Article: String, CaseIterable {
    case archeryBasics
    case correctStance
    case longShotBasics
    case aimTactics
    case inclineShot
    
    var image: ImageResource {
        switch self {
        case .archeryBasics: return .art1
        case .correctStance: return .art2
        case .longShotBasics: return .art3
        case .aimTactics: return .art4
        case .inclineShot: return .art5
        }
    }
    
    var title: String {
        switch self {
        case .archeryBasics: return "Archery Basics"
        case .correctStance: return "Correct Stance"
        case .longShotBasics: return "Long Shot Basics"
        case .aimTactics: return "Aim Tactics"
        case .inclineShot: return "Incline Shot"
        }
    }
    
    var description: String {
        switch self {
        case .archeryBasics:
            return "Learn the fundamental principles of archery that every beginner should know. This guide covers essential equipment, safety rules, and the basic mechanics of shooting a bow."
        case .correctStance:
            return "Your stance is the foundation of every shot. Discover how to position your feet, align your body, and maintain balance for consistent and accurate shooting."
        case .longShotBasics:
            return "Master the art of shooting at extended distances. Understand arrow trajectory, wind compensation, and the adjustments needed for hitting targets far away."
        case .aimTactics:
            return "Improve your accuracy with proven aiming techniques. Learn about sight alignment, anchor points, and mental focus strategies used by professional archers."
        case .inclineShot:
            return "Shooting uphill or downhill requires special adjustments. This article explains how gravity affects your arrow and how to compensate for elevation changes."
        }
    }
    
    var tips: [String] {
        switch self {
        case .archeryBasics:
            return [
                "Always inspect your equipment before shooting",
                "Start with a lower draw weight bow to build proper form",
                "Never dry fire your bow — always use an arrow"
            ]
        case .correctStance:
            return [
                "Keep your feet shoulder-width apart",
                "Distribute your weight evenly on both feet",
                "Face perpendicular to the target with a slight hip turn"
            ]
        case .longShotBasics:
            return [
                "Use a higher anchor point for longer distances",
                "Account for wind direction and speed",
                "Practice consistent release to minimize arrow drift"
            ]
        case .aimTactics:
            return [
                "Focus on the target, not the arrow tip",
                "Develop a consistent anchor point on your face",
                "Breathe steadily and release during a natural pause"
            ]
        case .inclineShot:
            return [
                "Aim lower than you think when shooting uphill or downhill",
                "Bend at the waist, not just your arms",
                "Use the horizontal distance to the target, not the actual distance"
            ]
        }
    }
}

