//
//  BasetTableViewCell.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import UIKit
import Combine
class BasetTableViewCell: UITableViewCell {
   var bindings = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUIs()
       
        bindData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUIs(){
        selectionStyle = .none
    }

    override func prepareForReuse() {
        applyTheme()
        bindings = Set<AnyCancellable>()
        bindData()
    }
    
    func applyTheme(){
        selectionStyle = .none
    }
    
    
    func bindData() {
        
    }
}
