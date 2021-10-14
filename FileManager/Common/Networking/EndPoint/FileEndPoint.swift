//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation


public enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum FileApi {
    case getFiles(path:String)
   
}

extension FileApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.dropboxapi.com/2/"
        case .qa: return "https://api.dropboxapi.com/2/"
        case .staging: return "https://api.dropboxapi.com/2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getFiles:
            return "file_requests/get"
       
        }
    }
    
    var httpMethod: HTTPMethod {
        var method:HTTPMethod = .get
        switch self {
        case .getFiles:
            method = .post
        default:
            method = .get
        }
       return method
    }
    
    var task: HTTPTask {
        switch self {
        case .getFiles(_):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters:nil,
                                                additionHeaders: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


