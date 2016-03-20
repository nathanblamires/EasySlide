
/*
* EasySlide
* LeftMenuViewController
*
* Author: Nathan Blamirs
* Copyright © 2016 Nathan Blamires. All rights reserved.
*/

import UIKit

class LeftMenuViewController: UIViewController, MenuDelegate, UITableViewDataSource, UITableViewDelegate {

    var easySlideNavigationController: ESNavigationController?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableCell")
        
        switch indexPath.item {
            case 0: cell?.textLabel!.text = "Menu"
            default: cell?.textLabel!.text = "Item \(indexPath.item+1)"
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = UIViewController();
        
        // get the new view controller
        switch indexPath.item {
            case 1: viewController = storyboard.instantiateViewControllerWithIdentifier("SampleView2")
            case 2: viewController = storyboard.instantiateViewControllerWithIdentifier("SampleView3")
            default: viewController = storyboard.instantiateViewControllerWithIdentifier("MainView")
        }
        
        // present next view
        if let slideController = self.easySlideNavigationController{
            slideController.setBodyViewController(viewController, closeOpenMenu: true, ignoreClassMatch: true)
        }
    }
}
