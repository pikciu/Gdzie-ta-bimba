//
//  GetTimesQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetTimesQueryHandler: QueryHandler {
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetTimesQuery
        let parameters = self.bodyBuilder.getTimes(query.bollard)
        let mapper = WrappedObjectMapper(ArrayMapper(TimeMapper()), pathToObject: "success", "times")
        let apiProvider = self.apiProvider
        let observable = Observable<Int>.timer(0, period: 20, scheduler: MainScheduler.instance).flatMap { _ in apiProvider.post(parameters, mapper: mapper) }
        return observable
    }
}
