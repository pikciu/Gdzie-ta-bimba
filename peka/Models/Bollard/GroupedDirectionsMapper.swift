//
//  GroupedDirectionsMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class GroupedDirectionsMapper: ObjectMappable {
    
    func mapToObject(_ json: JSON) -> GroupedDirections? {
    	let bollardMapper = BollardMapper(swapTagSymbol: true)
        let directionsMapper = ArrayMapper(DirectionMapper())
        guard let bollard = bollardMapper.mapToObject(json["bollard"]),
            let directions = directionsMapper.mapToObject(json["directions"]) else {
                return nil
        }
        let model = GroupedDirections(bollard: bollard, directions: directions)
        return model
    }
}
