//
//  ViewController.swift
//  SerializationSwift
//
//  Created by rone.loza@gmail.com on 04/18/2018.
//  Copyright (c) 2018 rone.loza@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkManager.shared().getItunesLookup(identifier: "1340448711") { (state: ResponseState, model: LookupMetadata?) -> (Void) in
            
            if (state == .Success) {
                
                if let data = model {
                    
                    print(data)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

