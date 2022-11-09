//
//  HomeViewController.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import UIKit
import Combine
class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData() {
        APIClient.shared.requestCombine(url: "http://188.166.226.161/api/v1/fatty/202221/lashio/main/admin/application/restaurants/termsandconditions", model: BaseResponse.self).sink { error in
            print("Error >>>" , error)
        } receiveValue: { data in
            print("Data >>>" , data)
        }.store(in: &bindings)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
