//
//  File.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

enum SocialLoginType: Int {
    case google = 0
    case faceBook
    case apple
}

struct Constants {
    struct Segue {
        static let verifyOTP = "segueToVerifyOtp"
        static let resetPassword = "segueToResetPassword"
    }

    struct Keys {
        static let environment = "currentEnvironment"
    }

    struct URLs {
        static let baseUrl = "http://localhost:8080/systango-boilerplate-swift-mvvm.com/"
        static let loginEndPoint = "login"
        static let production = "This is the Production base url"
        static let testing = "This is the Testing base url"
        static let development = "This is the Development base url"
    }

    struct Message {
        static let invalidUrl = "Invalid Url"
        static let logoutWarning = "Are you sure you want to logout?"
    }

    struct GoogleSignIn {
        static let clientId = "40572889225-1eguruuiukuie9tjdopuljadvoagv46s.apps.googleusercontent.com"
    }
}
