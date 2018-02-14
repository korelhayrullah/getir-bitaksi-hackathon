//
//  BaseViewController.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //since it is the getir-bitaksi-hackathon. I took the background image from www.getir.com.
        //I do not own or distribute the background image. It will only for this application which it will not be distributed unless your will.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "getir-background-img")!)
    }
}
