//
//  WebViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    private let url: URL
    
    
    // MARK: - LifeCycel
    init(with url: URL){
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        webView.load(URLRequest(url: self.url))
    }
    
    
    // MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    
    // MARK: - Selectors
    @objc private func doneButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
