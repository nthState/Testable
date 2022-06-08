//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation
import XCTest
import OSLog

/**
 Use https://regex101.com/ in PCRE Mode to test
 
 (\s) match a single space
 ([ \t]+) match any number of spaces or tabs
 
 */


open class BaseEvents: NSObject {
  
  public var app: XCUIApplication?
  
  let timeout: TimeInterval = 30
  
  public let logger = Logger(subsystem: "com.testable", category: "Events")

  //private var mapping: [Regex: Selector] = [: ]
  
  public var globalMap: [String: UIOperation] = [
    #"(?xi)(?-x:Feature:)(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.noop)),
    #"(?xi)(?-x:Scenario:)(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.noop)),
    #"(?xi)(?-x:When I.*)(?<action> launch)(?-x: the )(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.whenILaunch)),
    #"(?xi)(?-x:When I.*)(?<action> tap | press)(\s)(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.whenITap)),
    #"(?xi)(?-x:Then I type (?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.thenIType)),
    #"(?xi)(?-x:Then I see )(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.thenISee)),
    //        #"(?xi)(?-x:Then I see the text )(?<identifier>.*)"#: #selector(BaseEvents.thenISeeText),
    #"(?-x:The network state is )(?<networkState>unknown|restricted|unrestricted)"#: UIOperation.selector(#selector(BaseEvents.networkIs)),
    #"(?xi)(?-x:The server sends a push notification with )(?<json>.*)"#: UIOperation.selector(#selector(BaseEvents.sendPush)),
    #"(?xi)(?-x:And I get a push with )(?<title>.*)"#: UIOperation.selector(#selector(BaseEvents.receivePush)),
    #"(?-x:Requests to )(?<url>.*)(?-x:return)(?<json>.*)(?-x:with a)(?<httpCode>.*)"#: UIOperation.selector(#selector(BaseEvents.requestsTo)),
    #"(?-x:And I open )(?<url>.*)"#: UIOperation.selector(#selector(BaseEvents.openMagicLink)),
    #"(?xi)(?-x:And I swipe.*)(?<direction> left | right)(?-x: on )(?<identifier>.*)"#: UIOperation.selector(#selector(BaseEvents.swipe))
  ]
  
  init(app: XCUIApplication? = nil) {
    super.init()
    
    self.app = app
  }
  
}

extension BaseEvents {

  func add(regex: String, operation: UIOperation) {
    globalMap[regex] = operation
  }

}

extension BaseEvents {
  
  @objc public func noop() {
    logger.info("noop")
  }
  
  @objc public func whenILaunch(action: String, identifier: String) {
    logger.info("whenILaunch")
    
    logger.info("App State: \(String(describing: self.app?.state.rawValue))")
    
    app?.launch()
    
    logger.info("App State: \(String(describing: self.app?.state.rawValue))")
    
    sleep(2)
  }
  
  @objc public func whenITap(action: String, identifier: String) {
    logger.info("WhenI: \(action) \(identifier)")
    
    logger.info("App State: \(String(describing: self.app?.state.rawValue))")
    
    //print(XCUIApplication().debugDescription)
    //app?.buttons[identifier].isVisible(timeout: timeout)
    app?.buttons[identifier].tap()
  }
  
  @objc public func thenISee(text: String) {
    logger.info("ThenI: \(text)")
    
    let noQuotes = text.replacingOccurrences(of: "\"", with: "")
    
    app?.typeText(noQuotes)
  }
  
  @objc public func thenIType(identifier: String) {
    logger.info("ThenType: \(identifier)")
    
    let noQuotes = identifier.replacingOccurrences(of: "\"", with: "")
    
    guard let app = app else {
      return
    }
    
    if [app.otherElements[noQuotes].isVisible(),
        app.staticTexts[noQuotes].isVisible()].contains(where: { $0 == true }) {
      logger.info("Found: \(noQuotes)")
    } else {
      XCTFail("Couldn't find anything matching: \(noQuotes)")
    }
  }
  
  //    @objc public func thenISeeText(identifier: String) {
  //        logger.info("ThenISeeText: \(identifier)")
  //
  //        let noQuotes = identifier.replacingOccurrences(of: "\"", with: "")
  //
  //        guard let app = app else {
  //            return
  //        }
  //        XCTAssertTrue(app.staticTexts[noQuotes].isVisible())
  //    }
  
  @objc public func networkIs(networkState: String) {
    logger.info("NetworkIs: \(networkState)")
  }
  
  @objc public func sendPush(json: String) {
    logger.info("sendPush: \(json)")
  }
  
  @objc public func receivePush(title: String) {
    logger.info("receivePush: \(title)")
  }
  
  @objc public func requestsTo(url: String, json: String, httpCode: Int) {
    logger.info("requestsTo: \(url) \(json) \(httpCode)")
  }
  
  @objc public func openMagicLink(url: String) {
    logger.info("openMagiclink: \(url)")
  }
  
  @objc public func swipe(direction: String, identifier: String) {
    logger.info("swipe: \(direction) on \(identifier)")
    
    enum Direction: String {
      case left
      case right
      case up
      case down
    }
    
    let directionEnum = Direction(rawValue: direction.lowercased())
    
//    let element = app?.scrollViews[identifier]
//    
//    switch directionEnum {
//    case .left:
//      element?.swipeLeft()
//    case .right:
//      element?.swipeRight()
//    case .up:
//      element?.swipeUp()
//    case .down:
//      element?.swipeDown()
//    case .none:
//      fatalError("Could not determine swipe direction from input: \(direction)")
//    }
    
  }
  
}
