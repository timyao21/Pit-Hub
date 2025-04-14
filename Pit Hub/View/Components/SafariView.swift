//
//  SafariView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/9/25.
//

import SwiftUI
import SafariServices

struct IdentifiableURL: Identifiable {
    let url: URL
    var id: URL { url }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No update logic needed for now.
    }
}


