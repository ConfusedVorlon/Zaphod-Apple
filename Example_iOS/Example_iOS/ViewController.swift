//
//  ViewController.swift
//  Example_iOS
//
//  Created by Rob Jonson on 08/11/2021.
//

import UIKit
import Zaphod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func debugReset(_ sender: Any) {
        Zaphod.shared.debugReset()
    }

    @IBAction func showFAQ(_ sender: Any) {
        let faqURL = Zaphod.shared.faqURL
        openSafari(url: faqURL)
    }

}
