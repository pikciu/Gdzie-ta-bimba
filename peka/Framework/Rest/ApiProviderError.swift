//
//  ApiProviderError.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ApiProviderError: Error {
    case httpError(status: Int, json: JSON)
    case jsonMapping
    case noResponse
}
