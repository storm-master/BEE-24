import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    Image(selectedTab == tab ? tab.imageOn : tab.image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.articles))
}
