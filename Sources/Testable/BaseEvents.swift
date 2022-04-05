//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation
import XCTest

let globalMap: [String: Selector] = [
  #"(?xi)(?-x:Feature:.*)"#: #selector(BaseEvents.noop),
  #"(?xi)(?-x:When I.*)(?<action> tap | press)(?<identifier>.*)"#: #selector(BaseEvents.whenITap),
  #"(?xi)(?-x:Then I see)(?<identifier>.*)"#: #selector(BaseEvents.thenISee),
  #"(?-x:The network state is )(?<networkState>unknown|restricted|unrestricted)"#: #selector(BaseEvents.networkIs),
  #"(?xi)(?-x:The server sends a push notification with )(?<json>.*)"#: #selector(BaseEvents.sendPush),
  #"(?xi)(?-x:And I get a push with )(?<title>.*)"#: #selector(BaseEvents.receivePush),
  #"(?-x:Requests to )(?<url>.*)(?-x:return)(?<json>.*)(?-x:with a)(?<httpCode>.*)"#: #selector(BaseEvents.requestsTo),
  #"(?-x:And I open )(?<url>.*)"#: #selector(BaseEvents.openMagicLink)
]

open class BaseEvents: NSObject {

  var app: XCUIApplication?

  init(app: XCUIApplication? = nil) {
    super.init()

    self.app = app
  }

}

extension BaseEvents {

  @objc public func noop() {
    logger.info("noop")
  }

  @objc public func whenITap(action: String, identifier: String) {
    logger.info("WhenI: \(action) \(identifier)")

    app?.buttons[identifier].tap()
  }

  @objc public func thenISee(identifier: String) {
    logger.info("ThenI: \(identifier)")

    guard let app = app else {
      return
    }
    XCTAssertTrue(app.otherElements[identifier].isVisible())
  }

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

}
