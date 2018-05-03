//
//  Data_Read.swift
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

import UIKit
import HandyJSON

class Data_Read: NSObject {
    
    class outDataModel: HandyJSON {
        var status : Int = 0
        var desc : String = ""
        var data : Any?
        
        required init(){}
    }
    

    class func JSON_DATA(data : Any ,result : (_ is_success : Bool ,_ success_data : Any?) ->Void){
        
        if data is Dictionary<String, Any> {
            
            let out_data = data as? Dictionary<String,Any>
            if let data_model = JSONDeserializer<outDataModel>.deserializeFrom(dict: out_data) {
                
                if data_model.status == 10000 {
                    //请求成功，数据Model化
                    Data_Read().deal_into_data(data: data_model.data, result: { ( succ_data : Any?) in
                        result(true ,succ_data)
                    })
                    
                }else{
                    //请求失败
                    result(false ,nil)
                }
            }
        }
    }

    func deal_into_data(data : Any? ,result : (_ success_data : Any?) ->Void) {
        if data is Dictionary<String, Any> {
            //data是字典的情况
            let data_dic = data as? Dictionary<String,Any>
            if let data_model = JSONDeserializer<TestModel>.deserializeFrom(dict: data_dic) {
                
                result(data_model)
            }
            
        }else if data is Array<Any> {
            //data是数组的情况
            let data_arr = data as? Array<Any>
            var model_arr : Array<TestModel> = []
            for i in data_arr ?? [] {
                let data_dic = i as? Dictionary<String,Any>
                if let data_model = JSONDeserializer<TestModel>.deserializeFrom(dict: data_dic) {
                    
                    model_arr.append(data_model)
                }
            }
            result(model_arr)
        }
    }
    
    //判断整合之后的数据类型 1数组  2TestModel  3其他的
    class func data_type(data : Any?) -> Int {
        if data is Array<Any> {
            return 1
        }else if data is TestModel {
            return 2
        }else{
            return 3
        }
    }
}
