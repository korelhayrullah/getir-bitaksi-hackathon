//
//  ResultsVC.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

class ResultsVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
   
    //MARK: Properties
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataCountlabel: UILabel!
    var responses: [Data]!
    
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Response"
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.backgroundColor = UIColor.clear
        dataTableView.separatorStyle = .none
        dataCountlabel.textColor = UIColor.getirBitaksiHackatonBlue
        dataCountlabel.text = "In total of \(responses.count)"
    }
    
    //MARK: TableView Operations
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    internal func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DataCell else { return }
        cell.backgroundColor = UIColor.getirBitaksiHackatonBlue
        cell.setLabelColors(toColor: UIColor.white)
    }
    
    internal func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DataCell else { return }
        cell.backgroundColor = UIColor.getirBitaksiHackatonOrange
        cell.setLabelColors(toColor: UIColor.getirBitaksiHackatonBlue)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataCell else{
            fatalError("Dequeued cell is not an instance of DataCell!")
        }
        cell.tintColor = UIColor.white
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = false
        
        let seperator = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - 2, width: cell.frame.width, height: 2))
        seperator.backgroundColor = UIColor.getirBitaksiHackatonOrange
        cell.addSubview(seperator)
        
        cell.idLabel.text =         "Id: " + responses[indexPath.row].id
        cell.keyLabel.text =        "Key: " + responses[indexPath.row].key
        cell.valueLabel.text =      "Value: " + responses[indexPath.row].value
        cell.createdAtLabel.text =  "Created at: " + responses[indexPath.row].createdAt
        cell.totalCountLabel.text = "Total Count: " + String(responses[indexPath.row].totalCount)

        return cell
    }
    
}
