//
//  ViewController.swift
//  ios-airports
//
//  Created by Robin Post on 16/10/2017.
//  Copyright © 2017 Robin Post. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let database = DatabaseHelper.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let airports = database.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

