//
//  ViewController.swift
//  Helpora-iOS
//
//  Created by Alan Chu on 3/21/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import UIKit
import Helpora

class ViewController: UIViewController {
    @IBAction func openHelpora(_ sender: UIButton) {
        let jsonFile = Bundle.main.url(forResource: "index", withExtension: "json")
        let json = try! Data(contentsOf: jsonFile!)
        
        let decoder = JSONDecoder()
        let index = try! decoder.decode(HPAIndex.self, from: json)
        
        present(HPAHelporaView(withIndex: index), animated: true)
    }
}
