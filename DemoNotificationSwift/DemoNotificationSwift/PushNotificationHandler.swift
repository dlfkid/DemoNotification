//
//  PushNotificationHandler.swift
//  DemoNotificationSwift
//
//  Created by Ivan_deng on 2018/9/18.
//  Copyright © 2018年 SealDevelopmentTeam. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation
import UIKit

class PushNotificationHandler: NSObject {
  static let shared = PushNotificationHandler()
  
  static func sendLocalNotificationiOS10() {
    let content = UNMutableNotificationContent();
    content.title = "Introduction to Notifications";
    content.subtitle = "Session 707";
    content.body = "Woah! These new notifications look amazing! Don’t you agree?";
    content.badge = 1;
    
    // Trigger: select proper trigger for your local notification, it can be time base, calandar base or location base
    let timeBaseTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
    let calandarComponent = DateComponents(hour: 10, weekday: 3)
    
    let calandarBaseTrigger = UNCalendarNotificationTrigger(dateMatching: calandarComponent, repeats: true)
    
    let region = CLRegion()
    
    let locationBaseTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
    
    let requestIdentifier = "SampleLocalNotification"
    
    
    let localNotificationRequest = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: timeBaseTrigger)
    
    UNUserNotificationCenter.current().add(localNotificationRequest) { (error) in
      if error != nil {
        print("Failed to request local notification with error: \(error?.localizedDescription ?? "")")
      }
    }
  }
  
  static func sendLocalNotitifcationiOS8() {
    let notification = UILocalNotification()
    notification.fireDate = Date()
    notification.soundName = ""
    notification.timeZone = NSTimeZone.system
    notification.alertBody = "Woah! These new notifications look amazing! Don’t you agree?"
    let repeatInterval = NSCalendar.Unit.day
    notification.repeatInterval = repeatInterval
    UIApplication.shared.scheduleLocalNotification(notification)
  }
}

extension PushNotificationHandler: UNUserNotificationCenterDelegate {
  // implement delegate methods here
}
