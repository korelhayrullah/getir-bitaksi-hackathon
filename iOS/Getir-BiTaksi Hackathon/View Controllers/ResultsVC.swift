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
    
    //IBOutlets
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataCountlabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Variables
    var responses: [Data]!
    var responsesPerPage = [Data]()
    var startIndex = 0
    var page = 1
    
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        //some settings
        navigationItem.title = "Response"
        
        setButtons()
        
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.backgroundColor = UIColor.clear
        dataTableView.separatorStyle = .none
        
        //sorting according to the totalCount in ascending order
        responses = responses.sorted{ (s1, s2) -> Bool in
            if s1.totalCount > s2.totalCount{
                return false
            }
            return true
        }
        
        //appending the first 10 elements (if there any) to the responsesPerPage array
        for _ in 0...9{
            if startIndex == responses.count{
                startIndex -= 1
                break
            }
            responsesPerPage.append(responses[startIndex])
            startIndex += 1
        }
        
        //initally it is always hidden
        previousButton.isHidden = true
        
        //if the responses came from the post request are less than or equal to 10 then it means the next button won't be neccessary. So, hide it.
        if responses.count <= 10{
            nextButton.isHidden = true
        }
        
        dataCountlabel.textColor = UIColor.getirBitaksiHackatonOrange
        dataCountlabel.text = "Page \(page) with \(responsesPerPage.count) items in total of \(responses.count)"
    }
    
    //MARK: Settings
    
    private func setButtons(){
        let attributedStringPreviousButton =  NSMutableAttributedString(string: "Previous", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 15)!, NSAttributedStringKey.foregroundColor: UIColor.getirBitaksiHackatonBlue])
        previousButton.setAttributedTitle(attributedStringPreviousButton, for: .normal)
        previousButton.backgroundColor = UIColor.getirBitaksiHackatonOrange
        previousButton.layer.shadowColor = UIColor.getirBitaksiHackatonBlue.cgColor
        previousButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        previousButton.layer.shadowOpacity = 1
        previousButton.layer.shadowRadius = 2
        previousButton.layer.cornerRadius = 4
        
        let attributedStringNextButton =  NSMutableAttributedString(string: "Next", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 15)!, NSAttributedStringKey.foregroundColor: UIColor.getirBitaksiHackatonBlue])
        nextButton.setAttributedTitle(attributedStringNextButton, for: .normal)
        nextButton.backgroundColor = UIColor.getirBitaksiHackatonOrange
        nextButton.layer.shadowColor = UIColor.getirBitaksiHackatonBlue.cgColor
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.shadowRadius = 2
        nextButton.layer.cornerRadius = 4
    }
    
    //MARK: TableView Operations
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responsesPerPage.count
    }
    
    internal func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DataCell else { return }
        cell.backgroundColor = UIColor.clear
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
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 4
        
        //adding a custom seperator since the default one doesn't let us set the height
        let seperator = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - 2, width: cell.frame.width, height: 2))
        seperator.backgroundColor = UIColor.getirBitaksiHackatonOrange
        cell.addSubview(seperator)
        
        cell.idLabel.text =         "Id: " + responsesPerPage[indexPath.row].id
        cell.keyLabel.text =        "Key: " + responsesPerPage[indexPath.row].key
        cell.valueLabel.text =      "Value: " + responsesPerPage[indexPath.row].value
        cell.createdAtLabel.text =  "Created at: " + responsesPerPage[indexPath.row].createdAt
        cell.totalCountLabel.text = "Total Count: " + String(responsesPerPage[indexPath.row].totalCount)
        return cell
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        //the previous button first sets the index - the current responsesPerPage and then -10 because of the window size
        startIndex = (startIndex - responsesPerPage.count) - 10
        page -= 2
        nextButtonPressed(sender)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //first removing all the previous ones
        responsesPerPage.removeAll()
        for _ in 0...9{
            if startIndex == responses.count{
                break
            } else {
                responsesPerPage.append(responses[startIndex])
                startIndex += 1
            }
        }
        page += 1
        
        dataCountlabel.text = "Page \(page) with \(responsesPerPage.count) items in total of \(responses.count)"
        
        //checking the buttons appearance status if they need to be hidden or not
        
        if startIndex > 10{
            UIView.animate(withDuration: 0.5, animations: {
                self.previousButton.isHidden = false
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.previousButton.isHidden = true
            })
        }
        
        if startIndex == responses.count{
            UIView.animate(withDuration: 0.5, animations: {
                self.nextButton.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.nextButton.isHidden = false
            })
        }
        
        //reload table
        dataTableView.reloadData()
    }
}
