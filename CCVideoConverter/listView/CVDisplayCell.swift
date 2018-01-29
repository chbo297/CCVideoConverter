//
//  CVDisplayCell.swift
//  CCVideoConverter
//
//  Created by bo on 23/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

import Cocoa

class CVDisplayCell: NSCollectionViewItem {

    class func cellSize(width : CGFloat) -> NSSize {
        return NSSize.init(width: width-30, height: 160)
    }
    
    @IBOutlet weak var imgV: NSImageView!
    @IBOutlet weak var label11: NSTextField!
    @IBOutlet weak var label12: NSTextField!
    
    @IBOutlet weak var label21: NSTextField!
    @IBOutlet weak var label22: NSTextField!
    
    @IBOutlet weak var label31: NSTextField!
    @IBOutlet weak var label32: NSTextField!
    @IBOutlet weak var leftBut: NSButton!
    
    @IBOutlet weak var btext: NSScrollView!
    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.textView.isEditable = false
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hex: 0xececec).cgColor
        let ab = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 100, height: 100))
        ab.layer?.backgroundColor = NSColor.red.cgColor
        self.view.addSubview(ab)
        imgV.wantsLayer = true
        imgV.layer?.backgroundColor = NSColor.black.cgColor
        imgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.leading.equalTo(self.view).offset(20)
            make.height.equalTo(self.view).offset(-30)
            make.width.equalTo(imgV.snp.height)
        }
        
        btext.snp.makeConstraints { (make) in
            make.top.equalTo(imgV)
            make.leading.equalTo(imgV.snp.trailing).offset(20)
            make.centerY.equalTo(imgV)
            make.height.equalTo(imgV)
            make.trailing.equalTo(self.view).offset(-20)
        }
        
        label11.snp.makeConstraints { (make) in
            make.top.equalTo(imgV).offset(8)
            make.leading.equalTo(imgV.snp.trailing).offset(20)
        }
        label12.snp.makeConstraints { (make) in
            make.centerY.equalTo(label11)
            make.leading.equalTo(label11.snp.trailing).offset(20)
        }
        
        label21.snp.makeConstraints { (make) in
            make.top.equalTo(label11.snp.bottom).offset(10)
            make.leading.equalTo(label11)
        }
        label22.snp.makeConstraints { (make) in
            make.centerY.equalTo(label21)
            make.leading.equalTo(label21.snp.trailing).offset(20)
        }
        
        label31.snp.makeConstraints { (make) in
            make.top.equalTo(label22.snp.bottom).offset(10)
            make.leading.equalTo(label21)
        }
        label32.snp.makeConstraints { (make) in
            make.centerY.equalTo(label31)
            make.leading.equalTo(label31.snp.trailing).offset(20)
        }
        
        
    }
    
    func setData(item : ViewController.CCVideoItem) {
        if let st = item.info?.title {
            self.textView.string = st
        } else {
            self.textView.string = item.path as String
        }
        
        self.imgV.image = item.image
    }
    
}
