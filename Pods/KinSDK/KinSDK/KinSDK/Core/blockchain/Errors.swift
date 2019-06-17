//
//  Errors.swift
//  StellarErrors
//
//  Created by Kin Foundation.
//  Copyright © 2018 Kin Foundation. All rights reserved.
//

import Foundation

public enum StellarError: Error {
    case memoTooLong (Any?)
    case missingAccount
    case missingPublicKey
    case missingHash
    case missingSequence
    case missingBalance
    case missingSignClosure
    case urlEncodingFailed
    case dataEncodingFailed
    case dataDencodingFailed
    case signingFailed
    case destinationNotReadyForAsset (Error)
    case unknownError (Any?)
    case internalInconsistency
}

extension StellarError: LocalizedError {
    public var errorDescription: String? {
        return String("\(self)")
    }
}
