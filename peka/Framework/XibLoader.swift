//
//  XibLoader.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class XibLoader {
    fileprivate let xibName: String
    
    init(xibName: String) {
        self.xibName = xibName
    }
    
    func load(_ owner: UIView, autoresizingOptions: UIViewAutoresizing = [.flexibleWidth, .flexibleHeight]) -> UIView {
        let bundle = Bundle(for: type(of: owner))
        let nib = UINib(nibName: self.xibName, bundle: bundle)
        let views = nib.instantiate(withOwner: owner, options: nil)
        let view = views.first as! UIView
        
        view.frame = owner.bounds
        view.autoresizingMask = autoresizingOptions
        
        return view
    }
    
    func load() -> UIView {
        let nib = UINib(nibName: self.xibName, bundle: nil)
        let views = nib.instantiate(withOwner: nil, options: nil)
        let view = views.first as! UIView
        
        return view
    }
}
