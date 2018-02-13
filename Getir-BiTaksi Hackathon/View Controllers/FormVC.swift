//
//  FormVC.swift
//  Getir-BiTaksi Hackathon
//
//  Created by Korel Hayrullah on 13.02.2018.
//  Copyright © 2018 Getir de getirek. All rights reserved.
//

import UIKit

class FormVC: BaseViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var minCountTextField: UITextField!
    @IBOutlet weak var maxCountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var postFormButton: UIButton!
    
    var currentDate = Date()
    var currentlyActiveLabel: Int = -1
    var alert: UIAlertController!
    var responses = [Data]()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .white
        return indicator
    }()
    
    lazy var overView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor.getirBitaksiHackatonOrange
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        return view
    }()
    
    //MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(overView)
        //setting the UI elements
        navigationItem.title = "Form"
        setLabels()
        setDatePicker()
        setTextFields()
        setButton()
        minCountTextField.delegate = self
        maxCountTextField.delegate = self
        datePicker.alpha = 0
        
        //alert
        alert = UIAlertController(title: "Upsss!", message: "You cannot leave the fields blank.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overView.isHidden = true
        activityIndicator.isHidden = true
        startDateLabel.text = ""
        endDateLabel.text = ""
        minCountTextField.text = ""
        maxCountTextField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        overView.isHidden = false
    }
    
    //MARK: Settings
    
    private func setLabels(){
        startDateLabel.layer.cornerRadius = 5
        startDateLabel.layer.masksToBounds = true
        startDateLabel.textColor = UIColor.getirBitaksiHackatonBlue
        startDateLabel.isUserInteractionEnabled = true
        startDateLabel.tag = 0
        startDateLabel.layer.borderWidth = 0.3
        startDateLabel.layer.borderColor = UIColor.lightGray.cgColor
        let tapGestureRecognizer1 = UITapGestureRecognizer()
        tapGestureRecognizer1.addTarget(self, action: #selector(chooseDate(_:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        startDateLabel.addGestureRecognizer(tapGestureRecognizer1)
        
        endDateLabel.layer.cornerRadius = 5
        endDateLabel.layer.masksToBounds = true
        endDateLabel.textColor = UIColor.getirBitaksiHackatonBlue
        endDateLabel.isUserInteractionEnabled = true
        endDateLabel.tag = 1
        endDateLabel.layer.borderWidth = 0.3
        endDateLabel.layer.borderColor = UIColor.lightGray.cgColor
        let tapGestureRecognizer2 = UITapGestureRecognizer()
        tapGestureRecognizer2.addTarget(self, action: #selector(chooseDate(_:)))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        endDateLabel.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    private func setTextFields(){
        minCountTextField.keyboardType = .numberPad
        minCountTextField.textColor = UIColor.getirBitaksiHackatonBlue
        minCountTextField.tintColor = minCountTextField.textColor
        
        maxCountTextField.keyboardType = .numberPad
        maxCountTextField.textColor = UIColor.getirBitaksiHackatonBlue
        maxCountTextField.tintColor = maxCountTextField.textColor
    }
    
    private func setDatePicker(){
        datePicker.setValue(UIColor.getirBitaksiHackatonBlue, forKey: "textColor")
        datePicker.date = currentDate
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    private func setButton(){
        let attributedString =  NSMutableAttributedString(string: "Post Form", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 15)!, NSAttributedStringKey.foregroundColor: UIColor.getirBitaksiHackatonOrange])
        postFormButton.setAttributedTitle(attributedString, for: .normal)
        postFormButton.backgroundColor = UIColor.getirBitaksiHackatonBlue
        postFormButton.layer.shadowColor = UIColor.getirBitaksiHackatonBlue.cgColor
        postFormButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        postFormButton.layer.shadowOpacity = 1
        postFormButton.layer.shadowRadius = 2
        postFormButton.layer.cornerRadius = 4
    }
    
    //MARK: TextField Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5) {
            self.view.endEditing(true)
            if self.datePicker.alpha == 1{
                self.datePicker.alpha = 0
            }
        }
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        if datePicker.alpha == 1{
            UIView.animate(withDuration: 0.5, animations: {
                self.datePicker.alpha = 0
            })
        }
        textField.becomeFirstResponder()
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    //MARK: Segue Preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultsVC = segue.destination as? ResultsVC else { return }
        resultsVC.responses = responses
    }
    
    
    //MARK: Actions
    
    @objc private func dateChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let chosenDate = dateFormatter.string(from: datePicker.date)
        
        switch currentlyActiveLabel {
        case 0:
            startDateLabel.text = chosenDate
        case 1:
            endDateLabel.text = chosenDate
        default:
            print("No currently tapped label found!")
        }
    }
    
    @objc private func chooseDate(_ tapper: UITapGestureRecognizer){
        if datePicker.alpha == 0{
            UIView.animate(withDuration: 0.5, animations: {
                self.datePicker.date = self.currentDate
                self.datePicker.alpha = 1
            })
        }
        if let tag = tapper.view?.tag{
            currentlyActiveLabel = tag
        }
    }
    
    @IBAction func postFormButtonPressed(_ sender: UIButton) {
        if startDateLabel.text != "" && endDateLabel.text != "" && minCountTextField.text != "" && maxCountTextField.text != ""{
            
            overView.isHidden = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            
            let url = URL(string: "https://getir-bitaksi-hackathon.herokuapp.com/searchRecords")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
        
            let postString = "startDate=\(startDateLabel.text!)&endDate=\(endDateLabel.text!)&minCount=\(minCountTextField.text!)&maxCount=\(maxCountTextField.text!)"
            
            request.httpBody = postString.data(using: .utf8)
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    DispatchQueue.main.async {
                        //showing an alert if something goes wrong
                        let alert = UIAlertController(title: "Upsss!", message: "The load has been added to the completion queue. This will be processed once there is a connection.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated:  true)
                    }
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    
                    if let json = json{
                        if let recordsValues = json.value(forKey: "records") as? NSArray{
                            self.responses.removeAll()
                            var counter = 0
                            
                            for values in recordsValues{
                                guard let dictValue = values as? NSDictionary else { return }
                                
                                guard let idDictValue = dictValue.value(forKey: "_id") as? NSDictionary else { return }
                                
                                guard let id = idDictValue.value(forKey: "_id") as? String else { return }
                                guard let key = idDictValue.value(forKey: "key") as? String else { return}
                                guard let value = idDictValue.value(forKey: "value") as? String else { return }
                                guard let createdAt = idDictValue.value(forKey: "createdAt") as? String else { return }
                                guard let totalCount = dictValue.value(forKey: "totalCount") as? Int else { return }
                                
                                
                                let data = Data(id: id, key: key, value: value, createdAt: createdAt, totalCount: totalCount)
                                self.responses.append(data)
                                
                                counter += 1
                                if counter == 10{
                                    break
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            //waiting the values to be fetched and then present the next VC
                            self.activityIndicator.stopAnimating()
                            self.performSegue(withIdentifier: "ResultsVCSegue", sender: self)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
}

