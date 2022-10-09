//
//  Service.swift
//  MapApp
//
//  Created by Emil Guseynov on 09.10.2022.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private init() {
    }
    
    func loadInitialData(completion: @escaping ([MapAnnotation]?, Error?) -> Void) {
        let urlString = "https://run.mocky.io/v3/96149d36-4ce8-4d4b-a3ac-f937068a1d35"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                fatalError("error: \(err)")
            }
            do {
                let modelObjects = try JSONDecoder().decode([MapAnnotationModel].self, from: data!)
                let objects = modelObjects.compactMap(MapAnnotation.init)
                completion(objects, nil)
            } catch {
                completion(nil, err)
            }
        }.resume()
        
    }
}
