//
//  AppDelegate.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var navController: UINavigationController?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // intiial objects
    let initialModel = HomeModel(pools: [], searchFilter: nil)
    let initialViewController = TableViewController()
    let initialPresenter = HomePresenter(view: initialViewController, model: initialModel)
    initialViewController.presenter = initialPresenter
    
    // setup navigation controller
    let navController = UINavigationController(rootViewController: initialViewController)
    self.navController = navController
    
    // setup window
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = navController
    window.makeKeyAndVisible()
    self.window = window
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
  }
}
