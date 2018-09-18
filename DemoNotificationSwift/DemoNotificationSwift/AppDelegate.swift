//
//  AppDelegate.swift
//  DemoNotificationSwift
//
//  Created by Ivan_deng on 2018/9/18.
//  Copyright © 2018年 SealDevelopmentTeam. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  // MARK: - LifeCycle
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // You Must have push notification certificate first
    // Then switch your notifiaction capability to ON
    // registPushNotificationiOS8()
    registPushNotificationiOS10()
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

  // MARK: - Regist for deviceToken
  // iOS8:
  private func registPushNotificationiOS8() {
    let notificationType = UIUserNotificationType(rawValue: UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.alert.rawValue)
    let notificationSettings = UIUserNotificationSettings(types: notificationType, categories: nil)
    UIApplication.shared.registerUserNotificationSettings(notificationSettings)
  }
  
  // iOS10:
  private func registPushNotificationiOS10() {
    let pushNotificationCenter = UNUserNotificationCenter.current()
    pushNotificationCenter.delegate = PushNotificationHandler.shared
    registPushNotificationCategory()
    pushNotificationCenter.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
      if (granted) {
        // Got notification granted by user
        UIApplication.shared.registerForRemoteNotifications()
      }
      else {
        if error != nil {
          print("Error when requeset granted: \(error?.localizedDescription ?? "")")
        }
        else {
          print("Request was denied by user.")
        }
      }
    }
    // Show current notification settings
    pushNotificationCenter.getNotificationSettings {
      print("Current notification settings: \($0)")
    }
  }
  
  private func registPushNotificationCategory() {
    
  }
  
  // MARK: - CallBcak when succeed in registed to PushNotification
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = NSString(data: deviceToken, encoding: String.Encoding.utf8.rawValue)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    print("DeviceToken: \(token ?? "no token")")
    
    // Send this token to your provider server to initial push notification
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Token regist failed with error: \(error.localizedDescription)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    application.applicationIconBadgeNumber += 1
  }
  
}
