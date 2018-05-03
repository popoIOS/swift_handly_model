//
//  Test_ViewController.swift
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

import UIKit

class Test_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
            AFManager.getRequestURLString("http://app.saike.com/index.php?c=scene&m=getsceneinfo&page=1&platform=ios&sub_type=1&type=3&user_token=TAwMDAwMDM0OF9iZjQ3MTMyZTJiZTcwYjEzNDFjMzY1YjA5NTA3MjI2MF8xNTI1MjQxMjYwX2lvc181LjcuMTdfMTgwMDA%3D&version=5.7.17", parameter: [:], showProgress: self.view, success: { ( isSuccess : Bool,data : Any?) in
                
//                SWIFT数据解析
//                if is_succ && Data_Read.data_type(data: data) == 2 {
//                    let model : TestModel = data as! TestModel
//                    print(model.title)
//                    print(model.base?.userprovince ?? "0000")
//                    for i in model.actionlist ?? [] {
//                        print(i.aname)
//                    }
//                }
//                OC数据解析
//                if isSuccess && Data_read_OC.data_type(data) == 2 {
//                    let model : TestModel_OC = data as! TestModel_OC
//                    print(model.title)
//                    print(model.base?.userprovince ?? "0000")
//                    for i in model.actionlist ?? [] {
//                        print((i as! ActionModel_OC).aname)
//                    }
//                }

                
            }) { (error : Error?) in

            }
    
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("释放了-----------------------------")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
