import UIKit
import WebKit
import AVFoundation

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cấp quyền Micro
        AVAudioSession.sharedInstance().requestRecordPermission { _ in }
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        // Đọc mã script hellfire.js trong gói ứng dụng và tự động tiêm
        if let path = Bundle.main.path(forResource: "hellfire", ofType: "js"),
           let scriptSource = try? String(contentsOfFile: path, encoding: .utf8) {
            let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            config.userContentController.addUserScript(userScript)
        }
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // Giả lập giao diện Desktop/iPad để Discord không ép tải app AppStore
        webView.customUserAgent = "Mozilla/5.0 (iPad; CPU OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        
        view.addSubview(webView)
        
        if let url = URL(string: "https://discord.com/app") {
            webView.load(URLRequest(url: url))
        }
    }
}
