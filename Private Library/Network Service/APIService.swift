import Foundation
import Alamofire

protocol APIService{
    
}


extension APIService{
    
    static func getURL(_ path: String) -> String {
        return "http://INPUT_URL/" + path
    }
    static func getStatusCodeAndResult(response: DataResponse<Data>) -> [String:Any?]?
    {
        switch response.result {
        case .success :
            guard let statusCode = response.response?.statusCode 
                else {
                    print("Status Code Error is occurred")
                    return nil
            }
            guard let responseData = response.data
                else {
                    print("Response Data Error is occurred")
                    return nil
            }
            var resultStatusData:[String: Any?] = ["code": statusCode,
                                                   "data": nil]
            switch Int(statusCode)
            {
            case 200..<400:
                resultStatusData["data"] = responseData
                break
            default:
                break
            }
            return resultStatusData
        case .failure(let err) :
            print(err.localizedDescription)
            break
        }
        return nil
    }
}
