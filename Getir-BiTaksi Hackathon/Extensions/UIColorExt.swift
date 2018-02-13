//
//  UIColorExt.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

extension UIColor{
    //an initializer only for RGB values
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //Getir-BiTaksi-Hackaton app's color pallete
    static let getirBitaksiHackatonBlue = UIColor(red: 93, green: 62, blue: 188)
    static let getirBitaksiHackatonOrange = UIColor(red: 255, green: 209, blue: 14)
    
}

