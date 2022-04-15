//
//  ViewController.swift
//  ShowWebSite
//
//  Created by nicola on 11/04/22.
//

import UIKit
import WebKit
import AdSupport
import AppTrackingTransparency

struct RequestManager {
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    static func checkTrackingStatus(completionHandler: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                completionHandler(status)
                
            }
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        RequestManager.checkTrackingStatus { status in
            switch status {
            case .authorized:
                let identifier = RequestManager.getIDFA()
                print(identifier)
                self.webView.load(URLRequest(url: URL(string: "https://www.github.com")!))
            
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print(" restricted")
            @unknown default:
                break
            }
        }
    }
}

