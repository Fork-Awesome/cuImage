//
//  Constants.swift
//  cuImage
//
//  Created by HuLizhen on 10/01/2017.
//  Copyright © 2017 HuLizhen. All rights reserved.
//

import Foundation

struct Constants {
    // Assets
    static let statusItemIcon = "StatusItemIcon"
    static let draggingDestinationBox = "DraggingDestinationBox"
    static let succeededIndicator = "SucceededIndicator"
    static let failedIndicator = "FailedIndicator"
    static let generalPreferences = "GeneralPreferences"
    static let shortcutsPreferences = "ShortcutsPreferences"
    static let hostsPreferences = "HostPreferences"
    static let uploadProgress = "UploadProgress"
    static let alertSound = "AlertSound"
    static let dropSound = "DropSound"

    static let uploadProgressImagesCount = 13  // 0 ... 12
    static let maxSizeOfthumbnail: Float = 200
    
    // Use for generating random string.
    static let characterSet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    static let randomCharactersLength = 6
    
    // Used for validating host informations.
    static let testString = "Hello"
    
    // Keys in Info.plist.
    static let applicationName = "CFBundleName"
    static let iconFileName = "CFBundleIconFile"
    static let mainBundleIdentifier = "CFBundleIdentifier"
    static let launcherBundleIdentifier = "LauncherBundleIdentifier"
    static let shortVersion = "CFBundleShortVersionString"
    static let buildVersion = "CFBundleVersion"
    static let humanReadableCopyright = "NSHumanReadableCopyright"
    
    // Email information for feedback.
    static let emailRecipient = "ihulizhen@foxmail.com"
    static let emailSubject = "[cuImage Feedback]"
    static let emailBody = systemInformation()
    
    // Random crypto string in hex format for cryptor.
    // This hould not been changed, otherwise the data
    // encrypted previously will not be decrypted correctly.
    static let cryptoKey = String(bytes: [0x55, 0x63, 0x3A, 0x54,
                                          0x53, 0x6E, 0x67, 0x57,
                                          0x6E, 0x6F, 0x38, 0x24,
                                          0x4F, 0x33, 0x4F, 0x64], encoding: .utf8)!
    
    // Misc
    static let notificationPreferencesPane = "/System/Library/PreferencePanes/Notifications.prefPane"
}
