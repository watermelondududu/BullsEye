//
//  AboutViewController.swift
//  BullsEye
//
//  Created by watermelondududu on 2018/12/29.
//  Copyright © 2018 watermelondududu. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView : WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载本地html文件BullsEye
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
        //在线加载网页
       //if let url = URL.init(string : "https://www.jianshu.com/u/e68f6f037b27"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil) //nil?
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
