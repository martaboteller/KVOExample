//
//  ViewController.swift
//  KVOExample
//
//  Created by Marta Boteller on 02/01/2019.
//  Copyright © 2019 Marta Boteller. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //Referenciate elements from storyboard
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var existingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton! {
        didSet{
            addButton.isEnabled = false
        }
    }
    //Populate table
    var contacts = ["Maria", "Laura", "Mireia"]
    
    //Define an observation token
    var inputTextObservationToken: NSKeyValueObservation?
    
    //Create an observable property for the textField
    @objc dynamic var inputText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        //Define observer for new values
        //of the property inputText
        inputTextObservationToken = observe(\.inputText, options: .new, changeHandler: {(vc,change) in
            guard let updatedInputText = change.newValue as? String else {return}
            if self.contacts.contains(updatedInputText) {
                vc.existingLabel.text = "Contact already exists!"
                self.addButton.isEnabled = false
            }else{
                vc.existingLabel.text = ""
                self.addButton.isEnabled = true
            }
        })
        
    }
    
    //Reload table's data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contactsTableView.reloadData()
    }
    
    //Invalidate the observation token
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        inputTextObservationToken!.invalidate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.item]
        return cell
    }
    
    //Add new contact if not repeated on the tableView
    @IBAction func addAction(_ sender: Any) {
          let newContact = textField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        if !contacts.contains (newContact!) {
            contacts.append(newContact!)
            contactsTableView.reloadData()
        }
    }
   
    //If textField changes (Edit Changes) add textField.text to the property
    //where we are setting the observer
    @IBAction func textFieldTextDidChange() {
      inputText = textField.text
    }
    
}

