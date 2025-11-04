//
//  WebService.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 20.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware/ and then docs/OGAPI1.2.3.pdf
//

import Foundation

public enum ServiceRequest: Int {
    case showLog
    case clearLog
    case getVariables
    case getOptions
    case changeVariables
}

private struct Service
{
    let showLog: String = "jl"
    let getVariables: String = "jc"
    let getOptions: String = "jo"
    let changeVariables: String = "cc"
}

private var OpenGarageErrorDesc: [Int: String] = [
     1: "Success",
     2: "Missing device key or device key is incorrect",
     3: "New device key and confirmation key do not match",
    16: "Missing required parameters",
    17: "Value exceeds the acceptable range",
    18: "Provided data does not match required format",
    32: "Page not found or requested file missing",
    48: "Cannot operate on the requested station",
    64: "OTA firmware update failed"
]

public enum OpenGarageError: Int {
    
    case Success         = 1
    case Unauthorized    = 2
    case Mismatch        = 3
    case DataMissing     = 16
    case OutOfRange      = 17
    case DataFormatError = 18
    case PageNotFound    = 32
    case NotPermitted    = 48
    case UploadFailed    = 64
}

struct RequestObject
{
    var method: String
    var path: String
    var params: [String: Any]
    var param: [String: Any]
    var service: ServiceRequest
    var log: Bool
    
    init(method: String?, path: String?, params: [String: Any]?, service: ServiceRequest?, log: Bool?)
    {
        self.method = method ?? "GET"
        self.path = path ?? ""
        self.params = params ?? [:]
        self.service = service ?? ServiceRequest.showLog
        self.log = log ?? false
        self.param = self.params
        
        let service = Service()
        switch self.service {
        case ServiceRequest.showLog:
            self.params = [ "endpoint": service.showLog ]
        case ServiceRequest.getVariables:
            self.params = [ "endpoint": service.getVariables ]
        case ServiceRequest.getOptions:
            self.params = [ "endpoint": service.getOptions ]
        case ServiceRequest.changeVariables:
            self.params = [ "endpoint": service.changeVariables, "args": self.param["args"] as! String ]
        default:
            self.params = [ "endpoint": service.showLog ]
        }
    }
}

class WebService {
    
    private let decoder: JSONDecoder
    private var resourceUrl: URL
    private var urlRequest: URLRequest
    private let printLog: Bool
    
    public init(_ decoder: JSONDecoder = JSONDecoder(), requestObject: RequestObject) {
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .secondsSince1970
        
        var endpoint: String?
        if let endpt = requestObject.params["endpoint"] as? String {
            endpoint = endpt
            if endpoint != nil && endpoint != "" {
                if let args = requestObject.params["args"] as? String {
                    endpoint = "\(endpoint!)\(args)"
                }
            }
        }
        
        let resourceString = "\(requestObject.path)/\(endpoint ?? "")"
        guard let resourceUrl = URL(string: resourceString) else {
            preconditionFailure("Invalid static URL string: \(resourceString)")
        }
        self.resourceUrl = resourceUrl
        
        self.urlRequest = URLRequest(url: resourceUrl)
        self.urlRequest.httpMethod = requestObject.method
        self.urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.printLog = requestObject.log
    }
    
    public func decoded<T: Decodable>(_ objectType: T.Type,
                                      completion: @escaping (Result<T, ServiceError>) -> Void)  {
        do {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data
                else {
                    // Connection error
                    completion(.failure(.responseProblem("Connection error!")))
                    return
                }
                
                // Check MIME Type
                guard let mime = response?.mimeType, mime == "application/json" else {
                    completion(.failure(.responseProblem("Wrong MIME type!")))
                    return
                }
                
                // Success
                do
                {
                    // Data received from a network request
                    if let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                    {
                        #if DEBUG
                        if (self.printLog) {
                            print(jsonResponse)
                        }
                        #endif
                        // Check for error response
                        for (key, value) in jsonResponse {
                            let val = stringFromAny(value)
                            if (key == "result" && Int(val) != OpenGarageError.Success.rawValue)
                            {
                                    let errDesc = OpenGarageErrorDesc[Int(val)!]
                                    #if DEBUG
                                    print(errDesc!)
                                    #endif
                                    completion(.failure(.applicationError(errDesc!)))
                                    return
                            }
                        }
                    }
                }
                catch let parsingError
                {
                    #if DEBUG
                    print("Error", parsingError)
                    #endif
                }
                
                // Now parsing
                do
                {
                    let decodedResponse = try self.decoder.decode(T.self, from: jsonData);
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse))
                    }
                }
                catch
                {
                    DispatchQueue.main.async {
                        #if DEBUG
                        print(error)
                        #endif
                        completion(.failure(.decodingProblem("Decoding problem")))
                    }
                }
            }
            // Start the data task
            dataTask.resume()
        }
    }
    
}

