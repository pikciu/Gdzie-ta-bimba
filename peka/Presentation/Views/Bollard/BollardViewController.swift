//
//  BollardViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BollardViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: BollardViewModel!
	private var navigationDelegate: BollardNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: BollardViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    
	func installDependencies(viewModel: BollardViewModel, _ navigationDelegate: BollardNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollard(symbol: String) {
        self.viewModel.loadBollard(symbol).addDisposableTo(self.disposables)
    }
    
    func loadTimes(bollard: Bollard) {
        self.viewModel.loadTimesForBollard(bollard).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
	}
	
    private func setupBinding() {
        self.viewModel.times.asObservable()
            .bindTo(self.tableView.configurableCells(TimeCell.self))
            .addDisposableTo(self.disposables)
        
        //TODO
        self.viewModel.message.asObservable()
            .filter { $0.isNotEmpty }
            .take(1)
            .subscribeNext { [unowned self] value in
                let alertViewController = UIAlertController(title: nil, message: value, preferredStyle: .Alert)
                alertViewController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alertViewController, animated: true, completion: nil)
            }.addDisposableTo(self.disposables)
    }
    
    @IBAction func toggleFavorite() {
        self.viewModel.toggleFavorite()
    }
}
