//
//  NavigationController.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 19/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import Material

class NavigationController:Material.NavigationController {
    
    override open func prepare() {
        super.prepare()
    
            guard let v = navigationBar as? NavigationBar else {
                return
            }
    
            v.depthPreset = .none
            v.backgroundColor = Color.black
        
        statusBarStyle = .lightContent
    }
    
}
