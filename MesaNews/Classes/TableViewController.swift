////
////  TableViewController.swift
////  TableViewController
////
////  Created by MAC on 30/09/21.
////
//
//import Foundation
//
//class TableViewController: UITableViewDelegate, UITableViewDataSource {
//
//    override func viewDidLoad () {
//        //MARK: NEWS
//        self.getNews()
//
//    }
//
//    // number of rows in table view
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let count = self.news?.data.count else {
//            return 0
//        }
//
//        return count
//    }
//
//    // create a cell for each table view row
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as UITableViewCell?)!
//
//        cell.textLabel?.text = self.news?.data[indexPath.row].title
//        // Image Notice Resize
//        if let url = URL(string: (self.news?.data[indexPath.row].image_url)!){
//            let image = self.getImage(url: url)
//            let imageResized = UIImage.resize(image: image, targetSize: CGSize(width: 70, height: 70))
//            cell.imageView?.image = imageResized
//        }
//        //End Image Notice Resize
//        cell.textLabel?.textAlignment = .justified
//
//        return cell
//    }
//
//    // method to run when table view cell is tapped
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //        print(self.news?.data[indexPath.row].content)
//        //        print("You tapped cell number \(indexPath.row).")
//    }
//
//    func getNews() {
//        let news = NewsModel.NewsModelSend(current_page: 1, per_page: 5, published_at: "2020-07-09")
//        SVProgressHUD.show(withStatus: "CARREGANDO...")
//
//        NewsProvider.shared.getNews(parameters: news, rootvc: self, completion: {
//            (jsonNews) in
//            DispatchQueue.main.async {
//                self.news = jsonNews
//                self.tableView.reloadData()
//
//                SVProgressHUD.dismiss()
//            }
//        }) { (error, isInfo) in
//
//            SVProgressHUD.show(withStatus: "Erro ao mostrar as noticias!")
//
//        }
//    }
//
//    func getImage(url: URL) -> UIImage {
//        var Image: UIImage
//
//        guard var Image = UIImage(named: "no-Image") else {
//            return UIImage(named: "no-Image")!
//        }
//
//        let data = try? Data(contentsOf: url)
//
//        if let image = UIImage(data: data!){
//            Image = image
//        }
//
//        return Image
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let showNotice = segue.destination as! ShowNoticeController
//
//        guard let title = self.news?.data[0].title else { return }
//        guard let text = self.news?.data[0].content else { return }
//        guard let URLImage = URL(string: (self.news?.data[0].image_url)!) else { return }
//        let image = self.getImage(url: URLImage)
//        //        print(text)
//        showNotice.Title = title
//        showNotice.text = text
//        showNotice.image = image
//    }
//}
