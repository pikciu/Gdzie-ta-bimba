//
//  LineNameToRouteTypeConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class LineNameToRouteTypeConverter: Convertible {
    
    private let tramLines: [String] = {
        var lines = Array(0...29)
        lines.append(201)
        return lines.map { "\($0)" }
    }()
    
    func convert(value: String) -> RouteType {
        if self.tramLines.contains(value) {
            return .Tram
        }
        return .Bus
    }
}