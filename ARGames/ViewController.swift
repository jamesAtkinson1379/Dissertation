//
//  ViewController.swift
//  ARGames
//
//  Created by james atkinson on 05/03/2018.
//  Copyright © 2018 james atkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

