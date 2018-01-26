import Foundation
import Alamofire

enum Result<T> {
    case Success(T)
    case Failure(Int)
}
struct Token {
    static func getToken() -> [String:String]{
        guard let token = UserDefaults.standard.string(forKey: "token") else {return ["tt" : "Not exist Token"]}
        print(token)
        return ["token" : token]
    }
}
protocol APIService {
    
}

extension APIService  {
    static func getURL(path: String) -> String {
        return "http://YOUR_URL/" + path
    }
    static func getResult_StatusCode(response: DataResponse<Data>) -> Result<Any>? {
        switch response.result {
        case .success :
            guard let statusCode = response.response?.statusCode as Int? else {return nil}
            guard let responseData = response.data else {return nil}
            switch statusCode {
            case 200..<400 :
                return Result.Success(responseData)
            default :
                return Result.Failure(statusCode)
            }
        case .failure(let err) :
            print(err.localizedDescription)
        }
        return nil
    }
}
