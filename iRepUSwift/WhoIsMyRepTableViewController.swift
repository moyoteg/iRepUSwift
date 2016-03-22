//
//  WhoIsMyRep.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/19/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

enum RepSection: Int {
    case AllMembers = 0
    case AllRepresentatives
}

enum RepType: Int {
    case Representative = 0
    case Senator
}

enum SearchField: Int{
    
    case Name = 1
    case State = 2
}

class WhoIsMyRepTableViewController: UITableViewController, UITextFieldDelegate {
    
    // All Members
    @IBOutlet var zipCodeTextField: UITextField!
    
    // All Representatives
    @IBOutlet var representativeSegmentedControl: UISegmentedControl!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    
    var repsToShowArray:[Representative]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackgroundTapKeyboardDismiss()
        self.addPullToRefresh("clearFields")
        
        self.zipCodeTextField.returnKeyType = .Search
        self.nameTextField.returnKeyType = .Search
        self.stateTextField.returnKeyType = .Search
        
        // Default values
        self.zipCodeTextField.text = "84606"
        self.nameTextField.text = "smith"
        self.stateTextField.text = "UT"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableView Delegate Methods
  
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        switch RepSection(rawValue: indexPath.section)!{
        case .AllMembers:
            if !self.zipCodeTextFieldIsValid(){
                NotificationManager.sharedInstance.alertWithMessage("Zip Code is Invalid!!")
                return
            }
            WhoIsMyRepApiManager.API.getAllMembers(self.zipCodeTextField.text!) { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    print(".Success getAllMembers")
                    self.repsToShowArray = Representative.getRepresentativeCollection(data)
                    NotificationManager.sharedInstance.completionWithMessage("getAllMembers success")
                    self.performSegueWithIdentifier("showRepsSearchResult", sender: self)
                case .Failure(let error):
                    print(".Failure getAllMembers: Request failed with error: \(error)")
                }
                ProgressHudManager.sharedInstance.hide()
            }
            break
        case .AllRepresentatives where
            RepType(rawValue: representativeSegmentedControl.selectedSegmentIndex) == .Representative
                && SearchField(rawValue: indexPath.row) == .Name:
            if !self.nameTextFieldIsValid(){
                NotificationManager.sharedInstance.alertWithMessage("Name field is empty!")
                return
            }
            WhoIsMyRepApiManager.API.getAllRepresentativesByName(self.nameTextField.text!) { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    print(".Success getAllRepresentativesByName")
                    self.repsToShowArray = Representative.getRepresentativeCollection(data)
                    NotificationManager.sharedInstance.completionWithMessage("getAllRepresentativesByName success")
                    self.performSegueWithIdentifier("showRepsSearchResult", sender: self)
                case .Failure(let error):
                    print(".Failure getAllRepresentativesByName: Request failed with error: \(error)")
                }
                ProgressHudManager.sharedInstance.hide()
            }
            break
        case .AllRepresentatives where
            RepType(rawValue: representativeSegmentedControl.selectedSegmentIndex) == .Representative
                && SearchField(rawValue: indexPath.row) == .State:
            if !self.stateTextFieldIsValid(){
                NotificationManager.sharedInstance.alertWithMessage("State field is empty!")
                return
            }
            WhoIsMyRepApiManager.API.getAllRepresentativesByState(self.stateTextField.text!) { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    print(".Success getAllRepresentativesByState")
                    self.repsToShowArray = Representative.getRepresentativeCollection(data)
                    NotificationManager.sharedInstance.completionWithMessage("getAllRepresentativesByState success")
                    self.performSegueWithIdentifier("showRepsSearchResult", sender: self)
                case .Failure(let error):
                    print(".Failure getAllRepresentativesByState: Request failed with error: \(error)")
                }
                ProgressHudManager.sharedInstance.hide()
            }
            break
        case .AllRepresentatives where
            RepType(rawValue: representativeSegmentedControl.selectedSegmentIndex) == .Senator
                && SearchField(rawValue: indexPath.row) == .Name:
            if !self.nameTextFieldIsValid(){
                NotificationManager.sharedInstance.alertWithMessage("Name field is empty!")
                return
            }
            WhoIsMyRepApiManager.API.getAllSenatorsByName(self.nameTextField.text!) { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    print(".Success getAllSenatorsByName")
                    self.repsToShowArray = Representative.getRepresentativeCollection(data)
                    NotificationManager.sharedInstance.completionWithMessage("getAllSenatorsByName success")
                    self.performSegueWithIdentifier("showRepsSearchResult", sender: self)
                case .Failure(let error):
                    print(".Failure getAllSenatorsByName: Request failed with error: \(error)")
                }
                ProgressHudManager.sharedInstance.hide()
            }
            break
        case .AllRepresentatives where
            RepType(rawValue: representativeSegmentedControl.selectedSegmentIndex) == .Senator
                && SearchField(rawValue: indexPath.row) == .State:
            if !self.stateTextFieldIsValid(){
                NotificationManager.sharedInstance.alertWithMessage("State field is empty!")
                return
            }
            WhoIsMyRepApiManager.API.getAllSenatorsByState(self.stateTextField.text!) { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    print(".Success getAllSenatorsByName")
                    self.repsToShowArray = Representative.getRepresentativeCollection(data)
                    NotificationManager.sharedInstance.completionWithMessage("getAllSenatorsByName success")
                    self.performSegueWithIdentifier("showRepsSearchResult", sender: self)
                case .Failure(let error):
                    print(".Failure getAllSenatorsByName: Request failed with error: \(error)")
                }
                ProgressHudManager.sharedInstance.hide()
            }
            break
        default:
            print("not a valid index path")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: UITextField Delegate Methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == zipCodeTextField{
            if textField.text?.characters.count == 5 && string.characters.count == 1{
                return false
            }
        } else if textField == nameTextField{
            
        } else if textField == stateTextField{
            
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.zipCodeTextField {
            self.tableView.delegate?.tableView!(self.tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        } else if textField == self.nameTextField{
            self.tableView.delegate?.tableView!(self.tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: 1, inSection: 1))
        }else if textField == self.stateTextField{
            self.tableView.delegate?.tableView!(self.tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: 2, inSection: 1))
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == stateTextField{
            ActionSheetStringPicker.showPickerWithTitle("Select State", rows: Constants.stateNameAbbreviations.allKeys, initialSelection: 0, doneBlock: { (picker, selectedIndex, selectedObject) -> Void in
                let selectedState = selectedObject as! String
                self.stateTextField.text = Constants.stateNameAbbreviations.objectForKey(selectedState) as? String
                }, cancelBlock: { (picker) -> Void in
                    
                }, origin: self.view)
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {

    }
    
    //MARK: UIScrollView delegate methods
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    //MARK: Segueway delegate methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ViewRepsSearchResultTableViewController{
            vc.repsToShowArray = self.repsToShowArray
        }
    }
    
    
    //MARK: Textfield validations
    
    func zipCodeTextFieldIsValid() -> Bool{
        if self.zipCodeTextField.text?.characters.count < 5{
         return false
        } else{
            return true
        }
    }
    
    func nameTextFieldIsValid() -> Bool{
        if self.nameTextField.text?.characters.count < 1{
         return false
        } else{
            return true
        }
    }
    
    func stateTextFieldIsValid() -> Bool{
        if self.stateTextField.text?.characters.count < 1{
            return false
        } else{
            return true
        }
    }
    
    func clearFields(){
        self.zipCodeTextField.text = ""
        self.nameTextField.text = ""
        self.stateTextField.text = ""
        self.refreshControl?.endRefreshing()
    }
}
