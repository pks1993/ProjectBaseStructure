//
//  BaseViewModel.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import Foundation
import UIKit
import Combine
class BaseViewModel {
    var bindings = Set<AnyCancellable>()
    var viewcontroller : UIViewController?
    
}
