//
//  ViewController.swift
//  MesaNews
//
//  Created by MAC on 28/09/21.
//

import UIKit
import SVProgressHUD
import iCarousel

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, iCarouselDataSource {
    
    //MARK: DATA MODEL
    var news: NewsModel.NewsModelResult?
    var highlights: HighLightsModel.HighLightsModelResult?
    var index: Int = 0
    
    //MARK: CELL TABLEVIEW IDENTIFIER
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: MY CAROUSEL
    let myCarousel: iCarousel = {
        let carousel = iCarousel()
        carousel.type = .linear
        return carousel
    }()
    
    @IBOutlet weak var viewCarousel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: HIGHLIGHTS
        self.getHighLights()
        
        //MARK: NEWS
        self.getNews()
        
        //MARK: TABLEVIEW NEWS
        tableView.delegate = self
        tableView.dataSource = self
        
        //MARK: CAROUSEL OF NEWS
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        myCarousel.frame = self.viewCarousel.frame
    }
    
    //MARK: NUMBER OF ROWS IN TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.news?.data.count else {
            return 0
        }
        
        return count
    }
    
    //MARK: CREATE A CELL LOOP IN TABLE VIEW ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = self.news?.data[indexPath.row].title
        //MARK: IMAGE NOTICE RESIZE
        if let url = URL(string: (self.news?.data[indexPath.row].image_url)!){
            let image = self.getImage(url: url)
            let imageResized = UIImage.resize(image: image, targetSize: CGSize(width: 70, height: 70))
            cell.imageView?.image = imageResized
        }
        //MARK: END IMAGE NOTICE RESIZE
        cell.textLabel?.textAlignment = .justified
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showNotice()
    }
    
    //MARK: GET NOTICES
    func getNews() {
        let news = NewsModel.NewsModelSend(current_page: 1, per_page: 20, published_at: "2020-07-09")
        SVProgressHUD.show(withStatus: "CARREGANDO...")
        
        NewsProvider.shared.getNews(parameters: news, rootvc: self, completion: {
            (jsonNews) in
            DispatchQueue.main.async {
                self.news = jsonNews
                self.tableView.reloadData()
                
                SVProgressHUD.dismiss()
            }
        }) { (error, isInfo) in
            
            SVProgressHUD.show(withStatus: "Erro ao mostrar as noticias!")
            
        }
    }
    
    //MARK: GET NOTICE HIGHLIGHTS
    func getHighLights() {
        SVProgressHUD.show(withStatus: "CARREGANDO...")
        
        HighLightsProvider.shared.getHighLights(rootvc: self, completion: {
            (jsonHighLights) in
            DispatchQueue.main.async {
                self.highlights = jsonHighLights
                self.myCarousel.reloadData()
                
                SVProgressHUD.dismiss()
            }
        }) { (error, isInfo) in
            
            SVProgressHUD.dismiss()
            return
        }
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
    
    //MARK: SHOW THE PAGE OF DETAIL NOTICE
    func showNotice() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showNotice", sender: nil)
        }
    }

    //MARK: NUMBER OF ITEMS IN CAROUSEL
    func numberOfItems(in carousel: iCarousel) -> Int {
        guard let count = self.highlights?.data.count else {
            return 0
        }
        
        return count
    }
    
    //MARK: MAKE THE CAROUSEL IN VIEW
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var view: UIView
        view = UIView(frame: CGRect(x: 0, y: 0, width: self.viewCarousel.frame.width, height: self.viewCarousel.frame.height))
        view.backgroundColor = .clear
        let imageView = UIImageView(frame: view.bounds)
        
        //MARK: IMAGE NOTICE RESIZE IN CAROUSEL
        if let url = URL(string: (self.highlights?.data[index].image_url)!){
            let image = self.getImage(url: url)
            let imageResized = UIImage.resize(image: image, targetSize: CGSize(width: 50, height: 50))
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageResized
            view.addSubview(imageView)
        }
        //MARK: END IMAGE NOTICE RESIZE IN CAROUSEL
        
        return view
    }
}
