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
Pit App was designed and developed by [Junyu Yao (yjytim)](https://yjytim.com/). Caroline He provided art support.

The idea to develop Pit App came about as I observed over the years following F1 that accessing Chinese F1 information was quite fragmented. Many relied on various social media influencers to share updates. That’s why I decided to create an app exclusively for F1 fans—a tool that is both user-friendly and visually appealing.

Owning my own iOS app had always been my dream. After graduation, I self-taught SwiftUI and embarked on this development journey. As my first independent project, it may contain some bugs. I hope you will be patient and provide timely feedback so I can fix any issues quickly.

The entire process rekindled my initial passion for programming and exploring new ideas. I also documented my journey on YouTube, which led to the series “yjy's independent development” on the account “[197的大头和Caro](https://space.bilibili.com/626701417?spm_id_from=333.788.0.0)”.
"""

    private let aboutUs_cn = """
Pit App 全部是由[姚俊煜（yjytim）](https://yjytim.com/)设计开发完成的。Caroline He提供美术支持。

开发Pit的起因是我关注F1的这几年来发现获取中文F1信息的方式都很杂。大家都靠着各种社交媒体上的博主转发来获取资讯。所以我就有了这个“开发一个属于我们自己F1 粉丝的App。 想要给大家提供一个好用，好看的F1工具。

拥有一款属于自己的 iOS App 一直是我的梦想。毕业后，我自学了 SwiftUI 并开始了这款 App 的开发之旅。作为我首次独立开发的作品，难免会存在一些 Bug，希望大家能够包容并及时反馈问题，我会尽快进行修复。

整个开发的过程让我重新找到了最初学习编程的感觉，一直在探索新鲜的事物。我也用视频的方式记录下了我独立开发的整个过程，这才有了“[197的大头和Caro](https://space.bilibili.com/626701417?spm_id_from=333.788.0.0)”的帐号上“yjy的独立开发”这个系列。
"""

    // Computed property that returns the properly formatted content.
    private var contentText: AttributedString {
        if selectedLanguage == .chinese,
           let attributed = try? AttributedString(markdown: aboutUs_cn, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
            return attributed
        }
        return (try? AttributedString(markdown: aboutUs_en)) ?? AttributedString(aboutUs_en)
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
