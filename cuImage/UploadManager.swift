//
//  UploadManager.swift
//  cuImage
//
//  Created by HuLizhen on 03/01/2017.
//  Copyright © 2017 HuLizhen. All rights reserved.
//

import Cocoa

final class UploadManager {
    static let shared = UploadManager()
    var isUploading = false

    private var host: Host?
    
    private init() {
        host = QiniuHost(delegate: self)
    }
    
    /// Upload the image on pasteboard.
    /// - Parameter pasteboard: the pasteboard on which the image is, general pasteboard by default.
    func uploadImageOnPasteboard(_ pasteboard: NSPasteboard = NSPasteboard.general()) {
        isUploading = true
        guard isUploading else { return }
        guard let host = host else { return }
        let classes: [AnyClass] = [NSURL.self, NSImage.self]
        guard let objects = pasteboard.readObjects(forClasses: classes, options: nil) else { return }
        
        var image: NSImage?
        var name: String?
        
        if let url = objects.first as? URL {
            image = NSImage(contentsOf: url)
            name = url.lastPathComponent
            if url.pathExtension == "" {
                name = name! + "." + NSBitmapImageFileType.JPEG.string
            }
        } else {
            image = (objects.first as? NSImage)?.compression(by: 1.0)
            name = "Screenshot." + NSBitmapImageFileType.JPEG.string
        }
        
        if image != nil {
            host.uploadImage(image!, named: name!)
        }
    }
}

extension UploadManager: HostDelegate {
    func host(_ host: Host, isUploadingImageWithPercent percent: Float) {
        print("Percent: \(percent)")
        StatusItemController.shared.statusItemView.updateImage(with: percent)
    }
    
    func host(_ host: Host, didSucceedToUploadImageWithURLString urlString: String) {
        NSUserNotificationCenter.default.deliverNotification(withTitle: "Image Uploaded", subtitle: "", text: urlString)
        
        let markdownURL = "![](" + urlString + ")"
        let pasteBoard = NSPasteboard.general()
        pasteBoard.declareTypes([NSPasteboardTypeString], owner: nil)
        assert(pasteBoard.setString(markdownURL, forType: NSPasteboardTypeString),
               "Failed to write object to the general pasteboard")
        
        StatusItemController.shared.statusItemView.resetImage()
        isUploading = false
    }
    
    func host(_ host: Host, didFailToUploadImageWithError error: NSError) {
        isUploading = false
    }
}
