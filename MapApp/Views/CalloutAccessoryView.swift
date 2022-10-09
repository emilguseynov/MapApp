//
//  CalloutAccessoryView.swift
//  MapApp
//
//  Created by Emil Guseynov on 09.10.2022.
//

import UIKit
import MapKit
import TinyConstraints


class CalloutAccessoryView: UIView {
    
    var annotation: MapAnnotation
    
    var idClient = UILabel()
    var idClientAccount = UILabel()
    
    init(annotation: MapAnnotation){
        self.annotation = annotation
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        idClientSetup()
        
        let stackView = UIStackView(arrangedSubviews: [
            idClient, idClientAccount
        ])
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.edgesToSuperview()
        stackView.height(40)
    }
    
    fileprivate func idClientSetup() {
        idClient.text = "IDClient: \(String(annotation.idClient))"
        idClient.font = .boldSystemFont(ofSize: 20)
        
        idClientAccount.text = "IDClientAccount: \(String(annotation.idClientAccount))"
        idClientAccount.font = .systemFont(ofSize: 16)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
