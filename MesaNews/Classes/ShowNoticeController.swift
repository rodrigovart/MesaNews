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
    public var image: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        self.lblTitle.text = self.Title
        self.textView.text = self.text
        guard let URLImage = URL(string: self.image) else {return}
        self.imageView.image = self.getImage(url: URLImage)
    }
    
    //MARK: GET IMAGE NOTICE
    func getImage(url: URL) -> UIImage {
        let NoImage = UIImage(named: "no-Image")!
        
        guard let data = try? Data(contentsOf: url) else {
            return NoImage
        }
        
        guard let image = UIImage(data: data) else {
            return NoImage
        }
        
        return image
    }
}
