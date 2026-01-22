import SwiftUI

struct MainView: View {
    @State var currentTab: Tabs = .articles
    @State var showAddExercise: Bool = false
    @State var showAddProgress: Bool = false
    @State var exercisesRefreshTrigger: Bool = false
    @State var progressRefreshTrigger: Bool = false
    @State var showSettings: Bool = false

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    MainViewHeaderView(title: currentTab.title) {
                        showSettings = true
                    }
                    .navigationDestination(isPresented: $showSettings) {
                        SettingsView()
                    }
                    .padding(.horizontal, 20)
                    switch currentTab {
                    case .articles:
                        ArticlesListView()
                            .padding(.horizontal, 20)
                    case .exercises:
                        ExercisesView(showAddExercise: $showAddExercise, refreshTrigger: exercisesRefreshTrigger)
                            .padding(.horizontal, 20)
                    case .lessons:
                        TrainingMainView()
                            .padding(.horizontal, 20)
                    case .progress:
                        ProgressListView(showAddProgress: $showAddProgress, refreshTrigger: progressRefreshTrigger)
                            .padding(.horizontal, 20)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                    }
                    CustomTabBarView(selectedTab: $currentTab)
                        .padding(.horizontal, 20)
                }
                .bgSetup()

            }
            
            if showAddExercise {
                AddExerciseView(isPresented: $showAddExercise) {
                    exercisesRefreshTrigger.toggle()
                }
            }
            
            if showAddProgress {
                AddProgressView(isPresented: $showAddProgress) {
                    progressRefreshTrigger.toggle()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
