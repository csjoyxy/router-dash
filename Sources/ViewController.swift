import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    let defaultURL = "http://192.168.10.1/dashboard/"
    let urlKey = "serverURL"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "路由器"
        let settingsBtn = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(openSettings))
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPage))
        navigationItem.rightBarButtonItems = [settingsBtn, reloadBtn]
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        loadHome()
    }

    func serverURL() -> URL {
        let s = UserDefaults.standard.string(forKey: urlKey) ?? defaultURL
        return URL(string: s) ?? URL(string: defaultURL)!
    }

    func loadHome() {
        webView.load(URLRequest(url: serverURL()))
    }

    @objc func reloadPage() { webView.reload() }

    @objc func openSettings() {
        let alert = UIAlertController(title: "服务器地址", message: "家里用 192.168.10.1，出门用 Tailscale IP", preferredStyle: .alert)
        alert.addTextField { tf in
            tf.text = UserDefaults.standard.string(forKey: self.urlKey) ?? self.defaultURL
            tf.keyboardType = .URL
            tf.autocapitalizationType = .none
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "保存", style: .default) { _ in
            if let t = alert.textFields?.first?.text, !t.isEmpty {
                UserDefaults.standard.set(t, forKey: self.urlKey)
                self.loadHome()
            }
        })
        present(alert, animated: true)
    }
}
