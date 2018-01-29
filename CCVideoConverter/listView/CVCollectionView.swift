//
//  CVCollectionView.swift
//  CCVideoConverter
//
//  Created by bo on 22/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

import Cocoa



class CVCollectionView: NSCollectionView {

    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.collectionViewLayout = NSCollectionViewFlowLayout.init()
        
        
        
        
        //        self.sty
    }
    
//    override func viewDidMoveToWindow() {
//        self.reloadData()
//    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
