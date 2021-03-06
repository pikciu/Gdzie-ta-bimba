//
//  QueryRequestBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol QueryRequestBuilder: BodyRequestBuilder {
    func add(resource: String) -> QueryRequestBuilder
    func add(pathParameter: String?) -> QueryRequestBuilder
    func add(queryParameters: [String: String]) -> BodyRequestBuilder
    func add(bodyParameters parameters: [HttpBodyParameter]) -> BodyRequestBuilder
}
