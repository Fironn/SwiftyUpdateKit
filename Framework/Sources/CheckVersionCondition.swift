//
//  CheckVersionCondition.swift
//  SwiftyUpdateKit
//
//  Created by Masaki Ando on 2021/10/08.
//  Copyright © 2021 Hituzi Ando. All rights reserved.
//

import Foundation

/// The key of UserDefaults.standard.
/// The value retrieved with this key is Int value as yyyyMMdd representation.
public let SwiftyUpdateKitLastCheckVersionDateKey = "jp.hituzi.SwiftyUpdateKit.lastCheckVersionDateKey"

public protocol CheckVersionCondition: AnyObject {
    /// If returns true, checks the app version.
    func shouldCheckVersion() -> Bool
}

/// Always checks the app version.
open class CheckVersionConditionAlways: CheckVersionCondition {

    public init() {
    }

    open func shouldCheckVersion() -> Bool {
        true
    }
}

/// Does not check the app version whenever.
open class CheckVersionConditionDisable: CheckVersionCondition {

    public init() {
    }

    open func shouldCheckVersion() -> Bool {
        false
    }
}

/// Checks the app version one time by a day.
open class CheckVersionConditionDaily: CheckVersionCondition {

    public init() {
    }

    open func shouldCheckVersion() -> Bool {
        let lastDate = UserDefaults.standard.integer(forKey: SwiftyUpdateKitLastCheckVersionDateKey)
        let today = Utility.currentDate()

        guard lastDate < today else { return false }

        let ud = UserDefaults.standard
        ud.set(today, forKey: SwiftyUpdateKitLastCheckVersionDateKey)
        ud.synchronize()

        return true
    }
}
