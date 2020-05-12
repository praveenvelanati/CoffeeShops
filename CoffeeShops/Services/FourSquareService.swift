
import Foundation

protocol FourSquareServiceType {
    func getCofeeShops(fsRequest: FourSquareRequestType, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}



class FourSquareService: FourSquareServiceType {
    
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getCofeeShops(fsRequest: FourSquareRequestType, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        
        guard let url = fsRequest.buildUrl() else {
            completion(.failure(FourSquareError.BadRequest))
            return
        }
        session.loadData(from: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(FourSquareError.Unknown))
                return
            }
            
            guard (response as? HTTPURLResponse) != nil else {
                completion(.failure(FourSquareError.BadResponse))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(FourSquareError.NoData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResponse.self, from: responseData)
                completion(.success(searchResults))
            } catch {
                completion(.failure(FourSquareError.DecodingError))
            }
        }
    }
    
}


protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}


extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }

        task.resume()
    }
}
