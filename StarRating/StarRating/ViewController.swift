//
//  ViewController.swift
//  StarRating
//
//  Created by Blake Andrew Price on 11/21/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Rating: 1 star"
    }
    
    //MARK: - Actions
    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 1 {
            title = "User Rating: \(ratingControl.value) star"
        } else {
            title = "User Rating: \(ratingControl.value) stars"
        }
    }
}
