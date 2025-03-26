//
//  About.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/12/25.
//
import SwiftUI

struct About: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .english

    private let aboutUs_en = """
Pit App was designed and developed by [Junyu Yao (yjytim)](https://yjytim.com/), with artistic support from Caroline He.

Over the past few years, I’ve noticed that accessing F1 news in China comes with high barriers and the available sources are quite fragmented. This inspired me to create an app specifically for F1 fans in China—a tool that’s both practical and visually appealing.

Having my own iOS app has always been a dream of mine. After graduating, I taught myself SwiftUI and embarked on the journey of developing this app. As my first independent project, it may have a few bugs; I hope you’ll be understanding and provide feedback so I can fix them as quickly as possible.

The whole development process rekindled the excitement I felt when I first learned to code and constantly explore new things. I also documented the entire journey through video, which led to the “yjy’s Independent Development” series on the “[197的大头和Caro](https://space.bilibili.com/626701417?spm_id_from=333.788.0.0)” channel, sharing this growth experience with everyone.
"""

    private let aboutUs_cn = """
Pit App 全部是由[姚俊煜（yjytim）](https://yjytim.com/)设计并开发完成的。Caroline He提供美术支持。

这几年来我发现在中国获取F1资讯的方式是有门槛的，且途径来源都很碎片化。这促使我萌生了开发一款专为中国F1粉丝打造的App的想法，想要给大家提供一个实用又好看的F1工具。

拥有一款属于自己的 iOS App 也一直是我的梦想。毕业后，我自学了 SwiftUI 并开始了这款 App 的开发之旅。作为我首次独立开发的作品，难免会有些许Bug，希望大家多多包涵，并及时反馈问题，我会尽快进行优化修复。

整个开发的过程让我重新找到了最初学习编程的感觉，一直在探索新鲜的事物。我也用视频的方式记录下了我独立开发的整个过程，这才有了“[197的大头和Caro](https://space.bilibili.com/626701417?spm_id_from=333.788.0.0)”的帐号上“yjy的独立开发”这个系列，希望与大家共享这段成长历程。
"""

    // Computed property that returns the properly formatted content.
    private var contentText: AttributedString {
        if selectedLanguage == .chinese {
            if let attributed = try? AttributedString(
                markdown: aboutUs_cn,
                options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            ) {
                return attributed
            }
        }
        
        if let attributed = try? AttributedString(
            markdown: aboutUs_en,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return attributed
        } else {
            // Fallback: return plain text if markdown parsing fails.
            return AttributedString(aboutUs_en)
        }
    }


    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(S.pitIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("About Us")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Divider()
                    
                    Text(contentText)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            About()
                .environment(\.locale, .init(identifier: "en"))
                .previewDisplayName("English")
            About()
                .environment(\.locale, .init(identifier: "zh"))
                .previewDisplayName("Chinese")
        }
    }
}
