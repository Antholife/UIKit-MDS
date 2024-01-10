//
//  DocumentViewController.swift
//  File Explorer
//
//  Created by Anthony Chahat on 09.01.2024.
//

import UIKit
import QuickLook

class DocumentViewController: QLPreviewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        if let imageName = imageName, let image = UIImage(named: imageName) {
            ImageView.image = image
        } else {
            ImageView.image = nil
        }
    }
}
