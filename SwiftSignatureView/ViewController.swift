//
//  ViewController.swift
//  SwiftSignatureView
//
//  Created by MyAdmin on 3/6/15.
//  Copyright (c) 2015 MyAdmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var signatureView : LimSignatureView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        signatureView = LimSignatureView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        self.view.addSubview(signatureView!)
    }
}

