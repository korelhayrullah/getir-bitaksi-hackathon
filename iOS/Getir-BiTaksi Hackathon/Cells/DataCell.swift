//
//  DataCell.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    //MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.getirBitaksiHackatonBlue
    }
    
    func setLabelColors(toColor: UIColor){
        idLabel.textColor = toColor
        keyLabel.textColor = toColor
        valueLabel.textColor = toColor
        createdAtLabel.textColor = toColor
        totalCountLabel.textColor = toColor
    }
}
