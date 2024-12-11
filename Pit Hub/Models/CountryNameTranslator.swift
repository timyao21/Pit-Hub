//
//  CountryNameTranslator.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct CountryNameTranslator {
    // Dictionary mapping English country names to Chinese names
    private static let countryNames: [String: String] = [
        "Sakhir": "巴林·萨基尔",
        "Jeddah": "沙特阿拉伯·吉达",
        "Shanghai": "中国·上海",
        "Melbourne": "澳大利亚·墨尔本",
        "Suzuka": "日本·铃鹿",
        "Imola": "意大利·伊莫拉",
        "Miami": "美国·迈阿密",
        "Monte Carlo": "摩纳哥·蒙特卡洛",
        "Montreal": "加拿大·蒙特利尔",
        "Catalunya": "西班牙·巴塞罗那",
        "Spielberg": "奥地利·斯皮尔伯格",
        "Silverstone": "英国·银石",
        "Hungaroring": "匈牙利·布达佩斯",
        "Spa-Francorchamps": "比利时·斯帕-弗朗科尚尔",
        "Zandvoort": "荷兰·赞德福特",
        "Monza": "意大利·蒙扎",
        "Baku": "阿塞拜疆·巴库",
        "Singapore": "新加坡",
        "Austin": "美国·奥斯汀",
        "Mexico City": "墨西哥·墨西哥城",
        "Interlagos": "巴西·圣保罗",
        "Las Vegas": "美国·拉斯维加斯",
        "Lusail": "卡塔尔·卢塞尔",
        "Yas Marina Circuit": "阿布扎比·亚斯码头",
        
        // Add more countries as needed
    ]

    /// Method to get the Chinese name for a given English country name
    /// - Parameter englishName: The English name of the country
    /// - Returns: The Chinese name of the country, or the original name if not found
    static func translate(englishName: String) -> String {
        return countryNames[englishName] ?? englishName
    }
}
