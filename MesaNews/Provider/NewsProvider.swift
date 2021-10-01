//
//  NewsProvider.swift
//  NewsProvider
//
//  Created by MAC on 28/09/21.
//

import Foundation
import SVProgressHUD

class NewsProvider{
    //MARK: - Properties
    private let httpClient = URLSessionAdapter()
    
    //MARK: - Singleton
    static let shared: NewsProvider = NewsProvider()
    
    //MARK: - Public Methods
    func getNews(parameters: NewsModel.NewsModelSend, rootvc: UIViewController, completion: @escaping (NewsModel.NewsModelResult) -> Void, onError: @escaping (String, Bool) -> Void){
        
        guard let news = try? JSONEncoder().encode(parameters) else {
            return
        }
        //        print(news)
        guard let postString = news.toPostString() else {
            return
        }
        //        print(postString)
        let url = URL(string: "\(BaseURL+URLNews+postString)")!
        //        print(url)
        // MARK: Http Default
        httpClient.get(url: url) { [weak self] result in
            
            guard self != nil else {return}
            
            switch result{
            case.success(let data):
                //                data?.printFormatted(msg: "NEWS JSON RESULT")
                if let result: NewsModel.NewsModelResult = data?.toModel() {
                    //                    print(result)
                    completion(result)
                }else {
                    SVProgressHUD.show(withStatus: "Erro ao processar o conteudo!")
                    return
                }
            case.failure(let erro):
                DispatchQueue.main.async {
                    switch erro {
                    case .ErrorJSON:
                        SVProgressHUD.show(withStatus: "Erro ao processar o conteudo!")
                    case .NoConnectivity:
                        SVProgressHUD.show(withStatus: "Sem conexao com a internet!")
                    case .ErrorServer:
                        SVProgressHUD.show(withStatus: "Erro ao acessar o conteudo, verifique mais tarde!")
                    }
                }
            }
        }
        
    }
}
