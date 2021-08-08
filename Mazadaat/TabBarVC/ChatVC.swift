//
//  ChatVC.swift
//  Mazadaat
//
//  Created by macbook on 11/30/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import WebKit

class ChatVC: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webChat: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NaveBarManager.navgationBar.showNave(vc: self)

        title = "الدردشة المباشرة"
           webChat.navigationDelegate = self
        let url = URL(string: "https://tawk.to/chat/5faffb50c52f660e89737bb0/default")!
        webChat.load(URLRequest(url: url))
        webChat.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
