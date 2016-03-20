
/*
* EasySlide
* SampleViewController
*
* Author: Nathan Blamirs
* Copyright © 2016 Nathan Blamires. All rights reserved.
*/

import UIKit

class SampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMenuButtons()
    }
    
    // MARK: Menu Methods
    
    private func getEasySlide() -> ESNavigationController {
        return self.navigationController as! ESNavigationController
    }
    
    private func addMenuButtons(){
        let leftButton = UIBarButtonItem(title: "Left", style: .Done, target: self, action: "openLeftView")
        let rightButton = UIBarButtonItem(title: "Right", style: .Done, target: self, action: "openRightView")
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
    }
    
    internal func openLeftView(){
        self.getEasySlide().openMenu(.LeftMenu, animated: true, completion: {})
    }
    
    internal func openRightView(){
        self.getEasySlide().openMenu(.RightMenu, animated: true, completion: {})
    }
}
