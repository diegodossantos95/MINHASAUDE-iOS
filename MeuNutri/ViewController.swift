//
//  ViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 14/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        Auth.auth().addStateDidChangeListener { (auth, user) in
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Auth.auth().signIn(withEmail: "santos.diegod@gmail.com", password: "di5e4go6") { (auth, error) in
            print(auth)
            print(error)

        }
    }


}

