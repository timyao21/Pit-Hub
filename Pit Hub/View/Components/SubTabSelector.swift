import SwiftUI

struct SubTabSelector: View {
    @Binding var selectedTab: Int
    let tabTitles: [String]
    
    @Namespace private var underlineAnimation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabTitles.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 4) {
                        Text(NSLocalizedString(tabTitles[index], comment: "Localized title text"))
                            .bold()
                            .foregroundColor(selectedTab == index ? Color(S.pitHubIconColor) : .secondary)
                        // Only the selected tab shows the animated underline.
                        if selectedTab == index {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color(S.pitHubIconColor))
                                .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                        } else {
                            // Maintain layout spacing with a transparent rectangle.
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = 0
        var body: some View {
            SubTabSelector(selectedTab: $selectedTab, tabTitles: ["Overview", "Details", "Stats"])
        }
    }
    return PreviewWrapper()
}
