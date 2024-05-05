import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    
    @Binding var name: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.backgroundColor = .clear // Set background color to clear
        webview.isOpaque = false
        
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url) {
            uiView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        } else {
            print("Failed to load gif: \(name)")
        }
    }
}
