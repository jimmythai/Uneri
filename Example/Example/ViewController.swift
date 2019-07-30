//
//  ViewController.swift
//  Example
//
//  Created by Atsushi Yamamoto on 2019/07/29.
//  Copyright © 2019 jimmythai. All rights reserved.
//

import UIKit
import Uneri

final class ViewController: UIViewController {
    private lazy var uneri: Uneri = {
        let frame = CGRect(x: 0, y: view.frame.maxX, width: view.frame.size.width, height: view.frame.size.height / 2)
        let uneri = Uneri(frame: frame)
        
        return uneri
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(uneri)
    }
}
