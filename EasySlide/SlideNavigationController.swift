
/*
* EasySlide
* SlideNavigationController
*
* Author: Nathan Blamirs
* Copyright © 2016 Nathan Blamires. All rights reserved.
*/

import UIKit

class SlideNavigationController: ESNavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // set left menu view controllers
        let optionalLeftVC = self.storyboard?.instantiateViewControllerWithIdentifier("LeftMenu")
        if let leftVC = optionalLeftVC {
            self.setupMenuViewController(.LeftMenu, viewController: leftVC)
            if var delegate: MenuDelegate = leftVC as? MenuDelegate{
                delegate.easySlideNavigationController = self
            }
        }
        
        // set right menu view controllers
        let optionalRightVC = self.storyboard?.instantiateViewControllerWithIdentifier("RightMenu")
        if let rightVC = optionalRightVC {
            self.setupMenuViewController(.RightMenu, viewController: rightVC)
            if var delegate: MenuDelegate = rightVC as? MenuDelegate{
                delegate.easySlideNavigationController = self
            }
        }
    }
}
