//
//  DraggedImageView.swift
//  CarRace
//
//  Created by MARTINS DIBANG on 09/04/2018.
//  Copyright © 2018 MARTINS DIBANG. All rights reserved.
//

import UIKit

class DraggedImageView: UIImageView {

    var startLocation: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startLocation = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentLocation = touches.first?.location(in: self)
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        self.center = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
    }
    
}
