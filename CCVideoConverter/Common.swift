//
//  Common.swift
//  CCVideoConverter
//
//  Created by bo on 26/01/2018.
//  Copyright © 2018 bo. All rights reserved.
//

import Foundation
extension DispatchQueue {
    
    class func cc_async_main(deley : Int, execute : @escaping () -> Void) {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(deley)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            execute()
        }
    }
    
}
