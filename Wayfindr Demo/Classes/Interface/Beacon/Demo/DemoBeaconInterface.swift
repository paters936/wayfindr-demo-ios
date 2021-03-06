//
//  DemoBeaconInterface.swift
//  Wayfindr Demo
//
//  Created by Wayfindr on 21/12/2015.
//  Copyright © 2015 Wayfindr.org Limited. All rights reserved.
//

import Foundation
import UIKit

private var displayDemoInterfaceWarning = true

final class DemoBeaconInterface: NSObject, BeaconInterface {
    
    
    // MARK: - Properties
    
    var needsFullBeaconData = false
    
    var monitorBeacons = true
    
    weak var delegate: BeaconInterfaceDelegate?
    
    weak var stateDelegate: BeaconInterfaceStateDelegate?
    
    var validBeacons: [BeaconIdentifier]?
    
    private(set) var interfaceState = BeaconInterfaceState.Initializing {
        didSet {
            stateDelegate?.beaconInterface(self, didChangeState: interfaceState)
        }
    }
    
    /// API Key used by Beacon manufacturer
    private let apiKey: String
    
    
    // MARK: - Initializers
    
    init(apiKey: String, monitorBeacons: Bool = true) {
        self.apiKey = apiKey
        
        super.init()

        if (displayDemoInterfaceWarning) {
            displayDemoInterfaceWarning = false

            let alert = UIAlertController(title: "No Beacon Implementation", message: "The app is running with a dummy beacon implementation. No positioning features will work. For more info see the 'Interface' and 'Starting a New Trial' sections in the README file.", preferredStyle: .Alert)
            let doneButton = UIAlertAction(title: WAYStrings.CommonStrings.Done, style: .Default, handler: nil)
            alert.addAction(doneButton)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
        
        // Perform Beacon SDK specific setup here
        // Update interfaceState property once it is setup or setup has failed
        
        interfaceState = .Operating
    }

    
    // MARK: - GET
    
    func getBeacons(completionHandler completionHandler: ((Bool, [WAYBeacon]?, BeaconInterfaceAPIError?) -> Void)?) {
        
        // Fetch currently known Beacons using SDK specific methods here
        // Create new WAYBeacon instances for each beacon returned by the Beacon SDK
        
        completionHandler?(true, [WAYBeacon](), nil)
    }
}
