//
//  WebVC.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 13.5.21..
//

import WebKit

class WebVC: UIViewController {

    // MARK: - API
    var urlString: String!
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebView(urlString: urlString)
    }
    
    // MARK: - Helper
    private func setWebView(urlString: String) {
        
        let theConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.frame, configuration: theConfiguration)
        let nsurl = URL(string: urlString)
        var nsrequest: URLRequest? = nil
        if let nsurl = nsurl {
            nsrequest = URLRequest(url: nsurl)
        }
        if let nsrequest = nsrequest {
            webView.load(nsrequest)
        }
        view.addSubview(webView)
    }
}
