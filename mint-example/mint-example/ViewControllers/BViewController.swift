//
//  BViewController.swift
//  mint-example
//
//  Created by Mustafa GUNES on 6.02.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizations.B.Title
        self.title = Localizations.B.ErrorEmptyField(min: "3", max: "6")
    }
}
