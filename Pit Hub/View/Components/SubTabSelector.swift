import SwiftUI

struct SubTabSelector: View {
    @Binding var selectedTab: Int
    let tabTitles: [String]
    
    @Namespace private var underlineAnimation
    
    var body: some View {
        Group {
            if tabTitles.count > 4 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) { // add spacing between buttons
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
                                    
                                    if selectedTab == index {
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(Color(S.pitHubIconColor))
                                            .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                    } else {
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.clear)
                                    }
                                }
                                // Each button gets a minimum width to avoid being too compressed.
                                .frame(minWidth: 80)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
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
                                
                                if selectedTab == index {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(Color(S.pitHubIconColor))
                                        .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                } else {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.clear)
                                }
                            }
                            // When there are 4 or fewer tabs, each takes up an equal share.
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
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

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = 0
        var body: some View {
            SubTabSelector(selectedTab: $selectedTab, tabTitles: ["Overview", "Details", "Stats", "More", "Extra", "Tab6", "Tab7"])
        }
    }
    return PreviewWrapper()
}
