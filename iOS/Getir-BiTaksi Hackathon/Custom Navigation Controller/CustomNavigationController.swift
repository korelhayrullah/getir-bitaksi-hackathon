//
//  CustomNavigationController.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.getirBitaksiHackatonBlue
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.getirBitaksiHackatonOrange]
        navigationBar.tintColor = UIColor.getirBitaksiHackatonOrange
        
    }
}
