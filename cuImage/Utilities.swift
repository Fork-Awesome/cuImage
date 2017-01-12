//
//  Utilities.swift
//  cuImage
//
//  Created by HuLizhen on 07/01/2017.
//  Copyright © 2017 HuLizhen. All rights reserved.
//

import Cocoa
import ServiceManagement

func launchAtLogin(_ launch: Bool) {    
    SMLoginItemSetEnabled(Constants.launcherBundleIdentifier as CFString, launch)
}

func keepWindowsOnTop(_ top: Bool) {
    for window in NSApp.windows {
        if window.isMember(of: NSWindow.self) {
            window.level = Int(CGWindowLevelForKey(top ? .floatingWindow : .normalWindow))
        }
    }
}
