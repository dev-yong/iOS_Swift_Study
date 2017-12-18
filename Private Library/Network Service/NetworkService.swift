import Foundation
import Alamofire
import SwiftyJSON

struct NetworkService: APIService{
    
    static func requestMultipartFormData(url: String, parameter: [String : Any?]?, completion: @escaping ([String:Any?])->())
    {
        Alamofire.upload(multipartFormData: {
            (multipartFormData) in
            
            guard let guardedParameter = parameter else {return}
            for (key, value) in guardedParameter {
                if(key != "image"){
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
                else {
                    if let img = value as? UIImage {
                        self.addImageData(multipartFormData: multipartFormData, image: img, key: key, imageName: guardedParameter["nickname"] as! String)
                    }
                }
            }
        },
                         usingThreshold: UInt64.init(),
                         to: self.getURL(url),
                         method: .post,
                         headers: nil, encodingCompletion: {
                            (encodingResult) in
                            switch encodingResult {
                            case .success(let uploadResponse, _, _) :
                                print("Encoding Success")
                                uploadResponse.responseData(){
                                    (response) in
                                    print(response)
                                    guard let resultData = getStatusCodeAndResult(response: response)
                                        else {
                                            print("Request MultipartFormData Result Data Error is occurred")
                                            return
                                    }
                                    completion(resultData)
                                }
                                break
                            case .failure(let error) :
                                print("Encoding Fail")
                                print(error.localizedDescription)
                                break
                            }
        })
    }
    
    static func request(url: String, parameter: [String : Any]? ,completion: @escaping ([String:Any?])->())
    {
        let url = self.getURL(url)
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseData(){
            (response) in
            
            guard let resultData = getStatusCodeAndResult(response: response)
                else {
                    print("Requst Result Data Error is occurred")
                    return
            }
            completion(resultData)
        }
    }
    
    
    static func addImageData(multipartFormData: MultipartFormData, image: UIImage!, key: String!,  imageName: String!){
        var data = UIImagePNGRepresentation(image!)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: key, fileName: imageName+".png", mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 1.0)
            multipartFormData.append((data?.base64EncodedData())!, withName: key, fileName: imageName+".jpeg", mimeType: "image/jpeg")
        }
    }
}

//************* View Controller *************
func getData(){
    NetworkService.request(url: "[subURL]", parameter: parameter){
        (result) in
        guard let code = result["code"] as? Int,
            let data = result["data"] as? Data
            else {return}
        
        switch code
        {
        case 201..<400 :
            let responseJSON = JSON(data)
            let data = responseJSON["data"]
            break
        case 401:
            break
        case 500:
            break
        default:
            break
        }
    }
}


