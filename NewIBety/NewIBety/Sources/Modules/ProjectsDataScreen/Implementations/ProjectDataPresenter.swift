//
//  ProjectDataPresenter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import CoreLocation
import UIKit

class ProjectDataPresenter: NSObject,ProjectDataViewToPresenterProtocol {
    
    func updateProject(){
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProjectDataViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.updateProjectService()
    }
    
    
    var isUpdateState:Bool = false
    
    var isPhoneFieldFirstTimeWritten = true
    var isEmailFieldFirstTimeWritten = true
    var placeholderText1 = ""
    var placeholderText2 = ""
    
    func findYourLocationCoordinates(isUpdateState: Bool) {
        
        self.isUpdateState = isUpdateState
        let authreq = CLLocationManager.authorizationStatus()
        if authreq == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        else
        {
            if authreq == .denied || authreq == .restricted {
                view?.showLocationServiceDeniedAlert()
                return
            }
            
        }
        // 9
        if updatingLocation {
            stopLocationManager()
        } else {
            lastLocationError = nil
            lastGeocodingError = nil
            startLocationManager()
        }
    }
    
    
    var interector: ProjectDataPresentorToInterectorProtocol?
    var router: ProjectDataPresenterToRouterProtocol?
    var view: ProjectDataPresenterToViewProtocol?
    
    
    let locationManager = CLLocationManager()
    
    var location : CLLocation!
    
    
    var updatingLocation = false
    var addressStatus=""
    var lastLocationError: Error?
    
    let geocoder = CLGeocoder()
    var placemark:CLPlacemark!
    
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    var timer:Timer?
    
    
    func updateViews(isUpdateState: Bool) {
        
        self.isUpdateState = isUpdateState
        if userProject == nil{
            userProject = project_Details()
        }
        if isUpdateState {
            interector?.displayProjectDetails()
        }
    }
    
    
    func createProject() {
        interector?.createProjectService()
    }
    func performSegue(withIdentifier: String) {
        router?.performSegue(withIdentifier: withIdentifier)
    }
    
    func institiateViewController(with identifier: String, in index: Int) {
        router?.institiateViewController(with: identifier, in: index)
    }
}

extension ProjectDataPresenter:ProjectDataInterectorToPresenterProtocol{
    
    func showAlertForProjectUpdate(){
        view?.showAlertForProjectUpdate()
    }
    
    func showAlertForProjectCreation() {
        view?.showAlertForProjectCreation()
    }
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    func displayProjectDetails(with displayedProjectDetails: projectCreationDetails) {
        view?.displayProjectDetails(with: displayedProjectDetails)
    }
}


extension ProjectDataPresenter : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
        //MARK: 6
        if (error as NSError).code==CLError.locationUnknown.rawValue{
            return
        }
        lastLocationError=error
        location=nil
        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation=locations.last!
        print("didUpdateLocations: \(newLocation)")
        
        if newLocation.timestamp.timeIntervalSinceNow < -5{
            return
        }
        if newLocation.horizontalAccuracy<0
        {return}
        
        var distance=CLLocationDistance(DBL_MAX)
        
        if let location = location{
            distance=newLocation.distance(from: location)}
            if distance>5
            {self.location = nil}
        
        
        if location==nil || newLocation.horizontalAccuracy < location.horizontalAccuracy{
            
            location=newLocation
                
                print("\(location.coordinate.latitude) , \(location.coordinate.longitude) ******************")
                userProject.projectLatitude = location.coordinate.latitude
                userProject.projectLongitude = location.coordinate.longitude
                if isUpdateState{
                    
                    dicOfUpdateProject["latitude"] = location.coordinate.latitude
                    
                    dicOfUpdateProject["longitude"] = location.coordinate.longitude
                }
            
            lastLocationError=nil
            
            if newLocation.horizontalAccuracy<=locationManager.desiredAccuracy{
                
                print("*** we're done!")
                stopLocationManager()
                if(distance>0)
                {
                    print("\(distance)")
                    performingReverseGeocoding=false }
            }
            
            if !performingReverseGeocoding{
                
                print(" yooo ")
                performingReverseGeocoding=true
                geocoder.reverseGeocodeLocation(newLocation, completionHandler: {
                    
                    placemarks,error in
                    print("\(String(describing: placemarks?.last!))   mostafadfsdfsdfsdf")
                    
                    print("\(error.debugDescription.description)")
                    if error==nil , let p=placemarks , !p.isEmpty{
                        
                        //print("\(p.last!)")
                        self.placemark=p.last!
                        userProject.projectAddress = self.string(from: self.placemark)
                        
                        print("\(self.string(from: self.placemark))")
                        self.view?.updateProjectAddress(with: self.string(from: self.placemark))
                    }
                    else{
                        self.placemark=nil
                    }
                    
                    self.lastGeocodingError=error
                    self.performingReverseGeocoding=false
                })
            }
        }
        else if distance<1
        {
            //when the previous condition is false ,then location variable won't change it will still have old value and when we measure time difference will be always big
            let time=newLocation.timestamp.timeIntervalSince((location.timestamp))
            if time>10
            {
                print("*** force done!  \(time)")
                stopLocationManager()
            }
        }
    }
    
    @objc func didTimeOut(){
        
        if location==nil{
            stopLocationManager()
            lastLocationError=NSError(domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
        }
    }
    
    func startLocationManager(){
        //MAR:12
        //we write If's condition because if the user disabled Location Services completely on her device , it doesn't matter that rest of code execute
        //if the user disabled Location Services completely on her device that won't result error(denied)
        
        if CLLocationManager.locationServicesEnabled() {
            timer=Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(didTimeOut), userInfo: nil, repeats: false)
            updatingLocation=true
            locationManager.delegate=self
            lastLocationError=nil
            locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    //MARK:7
    func stopLocationManager(){
        if let timer=timer{
            
            timer.invalidate()
        }
        updatingLocation=false
        locationManager.delegate=nil
        locationManager.stopUpdatingLocation()
    }
    
    func string(from placemark: CLPlacemark) -> String {
        var line = ""
        line.add(text: placemark.subThoroughfare)
        line.add(text: placemark.thoroughfare, separatedBy: " ")
        line.add(text: placemark.locality, separatedBy: ", ")
        line.add(text: placemark.administrativeArea, separatedBy: ", ")
        line.add(text: placemark.postalCode, separatedBy: " ")
        line.add(text: placemark.country, separatedBy: ", ")
        print("((((((((((((((( \(line) ))))))))))))")
        return line }
    
}

extension ProjectDataPresenter : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.tag == 500{
            if isPhoneFieldFirstTimeWritten {
                
                
                //            text = textView.text
                if !isUpdateState{
                    placeholderText1 = textView.text
                    print("\(textView.text!)")
                    textView.text = ""}
                
                isPhoneFieldFirstTimeWritten = false
            }
            
            
        }
        
        if textView.tag == 501{
            if isEmailFieldFirstTimeWritten == true {
                
                //            text = textView.text
                if !isUpdateState{
                    placeholderText2 = textView.text
                    print("\(textView.text!)")
                    textView.text = ""}
                isEmailFieldFirstTimeWritten = false
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count>0{
            if textView.text != placeholderText1 || textView.text != placeholderText2{
                if textView.tag == 500{
                    print(textView.text!)
                    userProject.projectPhone = textView.text!
                    if isUpdateState{
                        
                        dicOfUpdateProject["phone"] =  textView.text!
                    }
                }
                if textView.tag == 501{
                    userProject.projectEmail = textView.text!
                    
                    if isUpdateState{
                        dicOfUpdateProject["email"] = textView.text!
                    }
                }
                
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        //        if textView.text.count>0{
        //
        //        }
        
        if textView.tag == 500{
            
            if !isPhoneFieldFirstTimeWritten ,  textView.text.count == 0{
                textView.text = placeholderText1
                isPhoneFieldFirstTimeWritten = true
            }}
        if textView.tag == 501{
            
            if !isEmailFieldFirstTimeWritten , textView.text.count == 0{
                textView.text = placeholderText2
                isEmailFieldFirstTimeWritten = true
            }}
    }
}
