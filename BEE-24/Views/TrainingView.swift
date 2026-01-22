import SwiftUI

enum TrainingStage: CaseIterable {
    case aim
    case inhale
    case release
    
    var image: ImageResource {
        switch self {
        case .aim: return .aimLesson
        case .inhale: return .inhaleLesson
        case .release: return .releaseLesson
        }
    }
    
    var color: Color {
        switch self {
        case .aim: return .appBlue
        case .inhale: return .appGreen
        case .release: return .appOrange
        }
    }
}

struct TrainingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentStage: TrainingStage = .aim
    @State private var stageTimeRemaining: Int = 5
    @State private var elapsedTime: Double = 0
    @State private var progress: Double = 0
    @State private var timer: Timer?
    @State private var isCompleted: Bool = false
    
    private let totalDuration: Double = 15.0
    private let stageDuration: Double = 5.0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    stopTimer()
                    dismiss()
                } label: {
                    Image(.exitButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 90)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Text("\(stageTimeRemaining)")
                    .font(.appFont(size: 60))
                    .foregroundColor(.white)
                    .frame(width: 125, height: 90)
                    .background(currentStage.color)
                    .cornerRadius(22)
                
                Image(currentStage.image)
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.appGreenDark)
            .cornerRadius(35)
            
            Spacer()
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.appGreenDark)
                        .frame(height: 50)
                    
                    Capsule()
                        .fill(Color.appOrange)
                        .frame(width: geometry.size.width * progress, height: 50)
                        .animation(.linear(duration: 0.05), value: progress)
                }
            }
            .frame(height: 50)
        }
        .padding(.horizontal, 20)
        .bgSetup()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        let interval: Double = 0.05
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            guard !isCompleted else { return }
            
            elapsedTime += interval
            progress = min(elapsedTime / totalDuration, 1.0)
            
            let currentStageElapsed = elapsedTime.truncatingRemainder(dividingBy: stageDuration)
            stageTimeRemaining = max(1, Int(ceil(stageDuration - currentStageElapsed)))
            
            if elapsedTime < 5 {
                currentStage = .aim
            } else if elapsedTime < 10 {
                currentStage = .inhale
            } else if elapsedTime < 15 {
                currentStage = .release
            }
            
            if elapsedTime >= totalDuration && !isCompleted {
                isCompleted = true
                stageTimeRemaining = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    stopTimer()
                    dismiss()
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    TrainingView()
}
