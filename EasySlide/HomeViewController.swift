
/*
* EasySlide
* HomeViewController
*
* Author: Nathan Blamirs
* Copyright © 2016 Nathan Blamires. All rights reserved.
*/

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var menuSegmentControl: UISegmentedControl!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var panningSwitch: UISwitch!
    @IBOutlet weak var shadowSwitch: UISwitch!
    @IBOutlet weak var disableSwitch: UISwitch!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeStepper: UIStepper!
    
    private var currentMenu: MenuType = .LeftMenu
    
    // data
    private var leftRevealType: RevealType = .SlideUnder
    private var rightRevealType: RevealType = .SlideUnder
    private var leftSpeed: CGFloat = 0.35
    private var rightSpeed: CGFloat = 0.35
    private var leftCanPan: Bool = true
    private var rightCanPan: Bool = true
    private var leftShadowEnabled: Bool = true
    private var rightShadowEnabled: Bool = true
    private var leftEnabled: Bool = true
    private var rightEnabled: Bool = true
    private var leftWidth: CGFloat = 250
    private var rightWidth: CGFloat = 250
    
    // MARK: Setup Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.layer.cornerRadius = 8.0
        self.setupControlAttributes()
        self.wireActions()
        self.updateViewToReflectDataValues()
        self.addMenuButtons()
        updateConfiggurations()
    }

    private func updateConfiggurations(){
        self.menuSegmentChanged()
        self.typeSegmentChanged()
        self.speedChanged()
        self.panChanged()
        self.shadowChanged()
        self.disableChanged()
        self.sizeChanged()
    }
    
    private func wireActions(){
        self.menuSegmentControl.addTarget(self, action: "menuSegmentChanged", forControlEvents: .ValueChanged)
        self.typeSegmentControl.addTarget(self, action: "typeSegmentChanged", forControlEvents: .ValueChanged)
        self.speedSlider.addTarget(self, action: "speedChanged", forControlEvents: .ValueChanged)
        self.panningSwitch.addTarget(self, action: "panChanged", forControlEvents: .ValueChanged)
        self.shadowSwitch.addTarget(self, action: "shadowChanged", forControlEvents: .ValueChanged)
        self.disableSwitch.addTarget(self, action: "disableChanged", forControlEvents: .ValueChanged)
        self.sizeStepper.addTarget(self, action: "sizeChanged", forControlEvents: .ValueChanged)
    }
    
    private func setupControlAttributes(){
        
        // speed
        self.speedSlider.minimumValue = 0
        self.speedSlider.maximumValue = 2
        self.speedSlider.value = Float(self.getMenuSpeed(self.currentMenu))
        
        // left size stepper
        self.sizeStepper.minimumValue = 0
        self.sizeStepper.maximumValue = floor(Double(self.view.frame.size.width/50)) - 1
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
    
    // MARK: Getting
    
    internal func getMenuRevealType(menu: MenuType) -> RevealType{
        return (self.currentMenu == .LeftMenu) ? self.leftRevealType : self.rightRevealType
    }
    
    internal func getMenuSpeed(menu: MenuType) -> CGFloat{
        return (self.currentMenu == .LeftMenu) ? self.leftSpeed : self.rightSpeed
    }
    
    internal func getMenuPan(menu: MenuType) -> Bool{
        return (self.currentMenu == .LeftMenu) ? self.leftCanPan : self.rightCanPan
    }
    
    internal func getMenuShadow(menu: MenuType) -> Bool{
        return (self.currentMenu == .LeftMenu) ? self.leftShadowEnabled : self.rightShadowEnabled
    }
    
    internal func getMenuDisable(menu: MenuType) -> Bool{
        return (self.currentMenu == .LeftMenu) ? self.leftEnabled : self.rightEnabled
    }
    
    internal func getMenuWidth(menu: MenuType) -> CGFloat{
        return (self.currentMenu == .LeftMenu) ? self.leftWidth : self.rightWidth
    }
    
    // MARK: Setting
    
    internal func setMenuRevealType(menu: MenuType, value: RevealType){
        if(menu == .LeftMenu){
           self.leftRevealType = value
        } else {
            self.rightRevealType = value
        }
    }
    
    internal func setMenuSpeed(menu: MenuType, value: CGFloat){
        if(menu == .LeftMenu){
            self.leftSpeed = value
        } else {
            self.rightSpeed = value
        }
    }
    
    internal func setMenuPan(menu: MenuType, value: Bool){
        if(menu == .LeftMenu){
            self.leftCanPan = value
        } else {
            self.rightCanPan = value
        }
    }
    
    internal func setMenuShadow(menu: MenuType, value: Bool){
        if(menu == .LeftMenu){
            self.leftShadowEnabled = value
        } else {
            self.rightShadowEnabled = value
        }
    }
    
    internal func setMenuDisable(menu: MenuType, value: Bool){
        if(menu == .LeftMenu){
            self.leftEnabled = value
        } else {
            self.rightEnabled = value
        }
    }
    
    internal func setMenuWidth(menu: MenuType, value: CGFloat){
        if(menu == .LeftMenu){
            self.leftWidth = value
        } else {
            self.rightWidth = value
        }
    }
    
    // MARK: Control Actions
    
    internal func menuSegmentChanged(){
        self.currentMenu = (self.menuSegmentControl.selectedSegmentIndex == 0) ? .LeftMenu : .RightMenu
        self.updateViewToReflectDataValues()
    }
    
    internal func typeSegmentChanged(){
        self.setMenuRevealType(self.currentMenu, value: RevealType(rawValue: self.typeSegmentControl.selectedSegmentIndex)!)
        self.updateViewToReflectDataValues()
        self.getEasySlide().setMenuRevealType(self.currentMenu, revealType: self.getMenuRevealType(self.currentMenu))
    }
    
    internal func speedChanged(){
        self.setMenuSpeed(self.currentMenu, value: CGFloat(self.speedSlider.value))
        self.updateViewToReflectDataValues()
        self.getEasySlide().setMenuAnimationSpeed(self.currentMenu, speed: self.getMenuSpeed(self.currentMenu))
    }

    internal func panChanged(){
        self.setMenuPan(self.currentMenu, value: self.panningSwitch.on)
        self.updateViewToReflectDataValues()
        self.getEasySlide().enableMenuPanning(self.currentMenu, enabled: self.getMenuPan(self.currentMenu))
    }
    
    internal func shadowChanged(){
        self.setMenuShadow(self.currentMenu, value: self.shadowSwitch.on)
        self.updateViewToReflectDataValues()
        self.getEasySlide().enableMenuShadow(self.currentMenu, enabled: self.getMenuShadow(self.currentMenu))
    }

    internal func disableChanged(){
        self.setMenuDisable(self.currentMenu, value: self.disableSwitch.on)
        self.updateViewToReflectDataValues()
        self.getEasySlide().enableMenu(self.currentMenu, enabled: self.getMenuDisable(self.currentMenu))
    }
    
    internal func sizeChanged(){
        self.setMenuWidth(self.currentMenu, value: CGFloat((self.sizeStepper.value + 1) * 50))
        self.updateViewToReflectDataValues()
        self.getEasySlide().setMenuWidth(self.currentMenu, width: self.getMenuWidth(self.currentMenu))
    }

    // MARK: Update View Elements
    
    private func updateViewToReflectDataValues(){
        
        self.menuSegmentControl.selectedSegmentIndex = self.currentMenu.rawValue
        self.typeSegmentControl.selectedSegmentIndex = self.getMenuRevealType(self.currentMenu).rawValue

        // speed
        let roundedLeftSpeedValue = Double(round(10*self.getMenuSpeed(self.currentMenu))/10)
        self.speedLabel.text = "Left Speed: \(roundedLeftSpeedValue)"

        // panning / shadow
        self.panningSwitch.on = self.getMenuPan(self.currentMenu)
        self.shadowSwitch.on = self.getMenuShadow(self.currentMenu)
        self.disableSwitch.on = self.getMenuDisable(self.currentMenu)
        
        // sizes
        self.sizeStepper.value = floor(Double(self.getMenuWidth(self.currentMenu)/50)) - 1
        self.sizeLabel.text = "Menu Width: \(Int(self.getMenuWidth(self.currentMenu)))"
        
        // disable size steppers if view is disabled
        self.sizeStepper.enabled = self.getMenuDisable(self.currentMenu)
    }
}
