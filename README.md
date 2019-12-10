# EasySlide

EasySlide is a simple and powerful slide in menu framework, that enables you to easily add a hamburger style slide in menu to your swift iOS application. It is powerful, configurable and completly contained in just one, 500 line class file.

__(Slide Along, Slide Over, Slide Under)__  
<img src="https://cloud.githubusercontent.com/assets/4186265/14058234/289a3438-f36e-11e5-8d73-e825ad8413bb.gif" width="225" height="400">
<img src="https://cloud.githubusercontent.com/assets/4186265/14058236/312e75dc-f36e-11e5-8b58-3c779f35cc49.gif" width="225" height="400">
<img src="https://cloud.githubusercontent.com/assets/4186265/14058238/37529b3c-f36e-11e5-8e1e-f6e3816a5cff.gif" width="225" height="400">

## Key Advantages
* Both __left__ and __right__ menus supported
* Configurable animation types (Slide Under, Slide Over, Slide Along)
* Supports reveal by panning 
* Written to support __autolayout__
* Basic API calls make integration a breeze

## Public Calls
``` swift
// setup
func setupMenuViewController(menu: MenuType, viewController: UIViewController)
func setBodyViewController(viewController: UIViewController, closeOpenMenu:Bool, ignoreClassMatch:Bool)

// open/close methods
func openMenu(menu: MenuType, animated:Bool, completion:(Void)->(Void))
func closeOpenMenu(animated:Bool, completion:(Void)->(Void))
    
// checking
func isMenuOpen(menu: MenuType) -> Bool
    
// configurations
func setMenuRevealType(menu: MenuType, revealType:RevealType)
func setMenuWidth(menu: MenuType, width:CGFloat)
func setMenuAnimationSpeed(menu: MenuType, speed:CGFloat)
func enableMenu(menu: MenuType, enabled:Bool)
func enableMenuShadow(menu: MenuType, enabled:Bool)
func enableMenuPanning(menu: MenuType, enabled:Bool)
func limitPanningAccess(shouldLimit:Bool, leftRange: CGFloat, rightRange:CGFloat)
```

## Optional Protocol
``` swift
protocol EasySlideDelegate{
    func easySlidePanAccessAvailable() -> Bool
}

protocol MenuDelegate{
    var easySlideNavigationController: ESNavigationController? { get set }
}
```

## Setup

Simply import ESNavigationController.swift into your project and set it as your Navigation Controllers class type.  
THAT's IT!   
Your Slide in menu is fully integrated and can now be configured to your liking.  

### Setting Up A Menu

To __set the menu view controller__, simply call the method   
  
```func setupMenuViewController(menu: MenuType, viewController: UIViewController)```
  
The __menu__ argument, specifies the menu you are setting (.LeftMenu or .RightMenu)  
The __viewController__ argument, specifies the view controller you are assigning to the menu  

### Changing The Current View Controller

To __change the current main root view controller__, simply call 
  
```setBodyViewController(viewController: UIViewController, closeOpenMenu:Bool, ignoreClassMatch:Bool)```  
   
The __viewController__ argument specifies the view controller you are assigning to the main view  
The __closeOpenMenu__ argument specifies if you want the menu to close after changing the view controller  
The __ignoreClassMatch__ argument specifies weather the view controller should be assigned if it is of the exact same class as the current main view controller.  

### Opening And Closing Menus  

To __open a menu__, Simply Call   
```openMenu(menu: MenuType, animated:Bool, completion:(Void)->(Void))```    

To __Close A Menu__, Simply Call      
```closeOpenMenu(animated:Bool, completion:(Void)->(Void))```    

To __Check If A Menu Is Open__, Simply Call   
```isMenuOpen(.LeftMenu)``` ``` ```

### Configurations  

__Enable/Disable A Menu__    
```enableMenu(.RightMenu, false)```

__Enable/Disable Shadows__    
```enableMenuShadow(.LeftMenu, true)```

__Enable/Disable Panning__    
```enableMenuPanning(.LeftMenu, false)```

Change the __Animation Type__    
```setMenuRevealType(.BothMenus, revealType:.SlideOver)```  

Change the __Menu Width__    
```setMenuWidth(.LeftMenu, width:250)```  

Change the __Animation Speed__     
```setMenuAnimationSpeed(.BothMenus, speed:0.25)```  

__Limit Panning To Touches Near The Edges Of The Screen__  
```limitPanningAccess(true, leftRange: 60, rightRange: 60)```   

### EasySlideDelegate

By default, any root view controller of the ESNavigationController can access side menus by panning, while all others have this panning access disabled. This is likely the behaviour most applications will need, however, if you wish to enable panning access from a pushed or presented view controller, the EasySlideDelegate can be used.  

__Enables/Disables Panning Menu Within Current Controller__  
```easySlidePanAccessAvailable() -> Bool```    
*n.b. This method does not interfere with the configured panning settings*    

### MenuDelegate
In order to access the __ESNavigationController__ object from within your menu, it is recommened that your menu classes conform to the protocol __MenuDelegate__. This protocol requires a single property be added, which can then be set to the __ESNavigationController__ object at the time of initialisation.

__Enables Access From Menu To ESNavigationController__  
```var easySlideNavigationController: ESNavigationController? { get set }```

## That's It!

Happy sliding!
