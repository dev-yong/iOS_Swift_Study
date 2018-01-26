import Foundation
import Alamofire

struct SignService: APIService {
    static func getSignData(url: String, parameter: [String : Any]?, completion: @escaping (Result<Any>)->()) {
        let url = self.getURL(path: url)
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            guard let resultData = getResult_StatusCode(response: response) else {return}
            completion(resultData)
        }
    }
}

//**********    Example Code    **********
//SignService.getSignData(url: "addedURL", parameter: ...) { (result) in
//    switch result {
//    case .Success(let response):
//        guard let data = response as? Data else {return}
//        let dataJSON = JSON(data)
//        print(dataJSON)
//    case .Failure(let failureCode):
//        print("Sign In Failure : \(failureCode)")
//          switch failureCode {
//              case ... :
//          }
//    }
//}
