//
//  HighLightsProvider.swift
//  HighLightsProvider
//
//  Created by MAC on 01/10/21.
//

import Foundation
import SVProgressHUD

class HighLightsProvider {
    //MARK: - Properties
    private let httpClient = URLSessionAdapter()
    
    //MARK: - Singleton
    static let shared: HighLightsProvider = HighLightsProvider()
    
    //MARK: - Public Methods
    func getHighLights(rootvc: UIViewController, completion: @escaping (HighLightsModel.HighLightsModelResult) -> Void, onError: @escaping (String, Bool) -> Void){
        
        let url = URL(string: "\(BaseURL+URLHights)")!
        
        // MARK: Http Default
        httpClient.get(url: url) { [weak self] result in
            
            guard self != nil else {return}
            
            switch result{
            case.success(let data):
                //                data?.printFormatted(msg: "HIGHLIGHTS JSON RESULT")
                if let result: HighLightsModel.HighLightsModelResult = data?.toModel() {
                    completion(result)
                }else {
                    SVProgressHUD.showError(withStatus: "Erro ao processar o conteudo!")
                    return
                }
            case.failure(let erro):
                DispatchQueue.main.async {
                    switch erro {
                    case .ErrorJSON:
                        SVProgressHUD.showError(withStatus: "Erro ao processar o conteudo!")
                    case .NoConnectivity:
                        SVProgressHUD.showError(withStatus: "Sem conexao com a internet!")
                    case .ErrorServer:
                        SVProgressHUD.showError(withStatus: "Erro ao acessar o conteudo, verifique mais tarde!")
                    }
                }
            }
        }
        
    }
}
