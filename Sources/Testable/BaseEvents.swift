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

    var app: XCUIApplication?

    let timeout: TimeInterval = 30

    public let logger = Logger(subsystem: "com.testable", category: "Events")

    public var globalMap: [String: Selector] = [
        #"(?xi)(?-x:Feature:.*)"#: #selector(BaseEvents.noop),
        #"(?xi)(?-x:When I.*)(?<action> launch)(?-x: the )(?<identifier>.*)"#: #selector(BaseEvents.whenILaunch),
        #"(?xi)(?-x:When I.*)(?<action> tap | press)(\s)(?<identifier>.*)"#: #selector(BaseEvents.whenITap),
        #"(?xi)(?-x:Then I see)(?<identifier>.*)"#: #selector(BaseEvents.thenISee),
        #"(?-x:The network state is )(?<networkState>unknown|restricted|unrestricted)"#: #selector(BaseEvents.networkIs),
        #"(?xi)(?-x:The server sends a push notification with )(?<json>.*)"#: #selector(BaseEvents.sendPush),
        #"(?xi)(?-x:And I get a push with )(?<title>.*)"#: #selector(BaseEvents.receivePush),
        #"(?-x:Requests to )(?<url>.*)(?-x:return)(?<json>.*)(?-x:with a)(?<httpCode>.*)"#: #selector(BaseEvents.requestsTo),
        #"(?-x:And I open )(?<url>.*)"#: #selector(BaseEvents.openMagicLink),
        #"(?xi)(?-x:And I swipe.*)(?<direction> left | right)(?-x: on )(?<identifier>.*)"#: #selector(BaseEvents.swipe)
    ]

    init(app: XCUIApplication? = nil) {
        super.init()

        self.app = app
    }

}

extension BaseEvents {

    func add(regex: String, selector: Selector) {
        globalMap[regex] = selector
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
        app?.buttons[identifier].isVisible(timeout: timeout)
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

    @objc public func swipe(direction: String, identifier: String) {
        logger.info("swipe: \(direction) on \(identifier)")

        enum Direction: String {
            case left
            case right
            case up
            case down
        }

        let direction = Direction(rawValue: direction)

        switch direction {
        case .left:
            app?.swipeLeft()
        case .right:
            app?.swipeRight()
        case .up:
            app?.swipeUp()
        case .down:
            app?.swipeDown()
        case .none:
            break
        }

    }

}
