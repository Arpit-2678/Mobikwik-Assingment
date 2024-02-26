//
//  DetailViewController.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 26/02/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
    }
    

}
