//
//  InterfaceController.swift
//  NetTimeWatch Extension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation
import RxSwift
import WatchKit

class NowInterfaceController: WKInterfaceController {
    @IBOutlet var beatsLabel: WKInterfaceLabel!
    private let bag = DisposeBag()

    override func willActivate() {
        super.willActivate()

//        // Test Mode only
//        if let label = self.beatsLabel {
//            label.setText("@423 \n .beats")
//        }

        let observable = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)

        observable.map({ _ in String(format: "@%05.1f \n .beats",
                                     floor(Date().beats * 10) / 10.0)})
            .subscribe(onNext: { [weak self] in
                self?.beatsLabel.setText($0)
            })
            .disposed(by: bag)
    }
}
