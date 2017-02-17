//
//  SettingsViewController.swift
//  CIS357-Homewokr2App
//
//  Created by Benjamin J. Benson on 2/16/17.
//  Copyright © 2017 Benjamin J. Benson. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate{
    func changeUnits(distanceType: String, bearingType: String)
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var distanceUnits: UIButton!
    
    @IBOutlet weak var bearingUnits: UIButton!
    
    @IBOutlet weak var pickerOutlet: UIPickerView!
    
    @IBOutlet var pickerCollection: [UIPickerView]!
    
    var pickerData: [String]!
    
    var distanceType: String = "changed"
    
    var bearingType: String = "not changed"
    
    var delegate: SettingsViewControllerDelegate?
    
    func passDataBackwards(){
        delegate?.changeUnits(distanceType: self.bearingType , bearingType: self.distanceType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOutlet.isHidden = true;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissPicker")
        self.pickerOutlet.delegate = self
        self.pickerOutlet.dataSource = self
        self.pickerData =  ["Kilometers","Miles"]
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(tap)
    }

    @IBAction func distUnitsPressed(_ sender: Any) {
        self.pickerData =  ["Miles", "Kilometers"]
        self.pickerOutlet.reloadAllComponents()
        self.pickerOutlet.isHidden = false;
    }
    @IBAction func onSavePress(_ sender: Any) {
        passDataBackwards()
    }
    @IBAction func bearingUnitsPressed(_ sender: Any) {
        self.pickerData =  ["Mils","Degrees" ]
        self.pickerOutlet.reloadAllComponents()
        self.pickerOutlet.isHidden = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelPress(_ sender: Any) {
        dismiss(animated: true, completion:nil);
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func dismissPicker(){
        self.pickerOutlet.isHidden = true
    }
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let temp: String = pickerData[row];
        if(temp == "Miles" || temp == "Kilometers"){
            distanceUnits.setTitle( temp, for: UIControlState.normal)
            self.distanceType = temp
        }else{
            bearingUnits.setTitle(temp, for: .normal);
            self.bearingType = temp
        }
        return temp;
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
