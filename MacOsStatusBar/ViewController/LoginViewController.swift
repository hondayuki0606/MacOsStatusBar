//
//  ViewController.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/08.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    public let statusItem = NSStatusBar.system.draggableStatusItem(withLength: NSStatusItem.squareLength)

    @IBOutlet weak var LoginID: NSTextField!
    @IBOutlet weak var Password: NSTextField!
    @IBOutlet weak var LoginButton: NSButton!
    @IBAction func LoginButton(_ sender: NSButton) {
       
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.statusItem.isVisible = true
        appDelegate.constructMenu()

    }
}

