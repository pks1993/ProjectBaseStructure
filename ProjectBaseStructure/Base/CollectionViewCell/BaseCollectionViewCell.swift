//
//  BaseCollectionViewCell.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import UIKit
import Combine
class BaseCollectionViewCell: UICollectionViewCell {
    var bindings = Set<AnyCancellable>()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        bindData()
    }
    
    func setupUI(){
        
    }

    func bindData(){
        
    }
    
}
