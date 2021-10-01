//
//  ShowNoticeController.swift
//  ShowNoticeController
//
//  Created by MAC on 30/09/21.
//

import UIKit

class ShowNoticeController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    public var Title: String = ""
    public var text: String = ""
    public var image: UIImage = UIImage(named: "no-Image")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        self.lblTitle.text = self.Title
        self.textView.text = self.text
        self.imageView.image = self.image
    }
}
