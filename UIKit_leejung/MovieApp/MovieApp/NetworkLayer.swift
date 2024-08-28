//
//  NetworkLayer.swift
//  MovieApp
//
//  Created by ohseungyeon on 8/29/24.
//

// 초보자는 무리데스
// 더 보기 좋게, 유지보수 쉽게 하려고 만드는 것 !
// 리팩토링
// 몇 번 해보면 자연스럽게 된다
// 협업에도 좋다
// 퀄리티 있는 추가 코딩작업이다

import Foundation

enum MovieAPIType{
    case justURL(urlString: String)
    case searchMovie(querys: [URLQueryItem])
}

enum MovieAPIError: Error{
    case badURL
}

class NetworkLayer{
    // only url
    // url + param
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    func request(type: MovieAPIType, completion: @escaping NetworkCompletion ) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do{
            let request = try buildRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                
                
                completion(data, response, error)
                
                
                
            }.resume()
            session.finishTasksAndInvalidate()
        }catch{
            print(error)
        }
        
    }
    
    func buildRequest(type: MovieAPIType) throws -> URLRequest {
        
        switch type{
        case .justURL(urlString: let urlString):
            
            guard let hasURL = URL(string: urlString) else {
                throw MovieAPIError.badURL
            }
            
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
        case .searchMovie(querys: let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            
            components?.queryItems = querys
            guard let hasURL = components?.url else{
                throw MovieAPIError.badURL
            }
            
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
        }
        
    }
}
    
    
    

