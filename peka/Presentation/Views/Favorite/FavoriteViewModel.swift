//
//  FavoriteViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class FavoriteViewModel {
    private let executor: Executor
    
    let bollards = Variable<[Bollard]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadFavouriteBollards() -> Disposable {
        let observable: Observable<[Bollard]> = self.executor.execute(GetFavoriteBollardsQuery())
        return observable.bindTo(self.bollards)
    }
    
    func nearesStop(coordinates: Coordinates) -> Observable<StopPointPushpin> {
        let observable: Observable<StopPointPushpin> = self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
        return observable
    }
    
    func toggleFavorite(bollard: Bollard) {
        let _: Bollard = self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
}