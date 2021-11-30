//
//  JsonErrors.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/29.
//

import Foundation

/// WebAPIのエラー
enum JsonError: Error {
    /// トークンが不正
    case invalidToken
    /// パラメータが不正
    case invalidParameters
    /// ユーザが見つからない
    case userNotFound
}
