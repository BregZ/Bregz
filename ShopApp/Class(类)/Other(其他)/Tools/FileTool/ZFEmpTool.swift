//
//  ZFEmpPlistTool.swift
//  ShopApp
//
//  Created by mac on 15/11/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFEmpTool: NSObject {
    
    class func createEmpPlist(fileString : String,emp_id : Int){

        let fileManager : NSFileManager = NSFileManager.defaultManager()
        
        let path : String = "\(fileString)/shopApp/\(emp_id)"
        
        let isCreateSuccess : Bool = fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil)
        
        if isCreateSuccess {
//            println("创建存储个人信息文件夹成功")
        }else{
            println("创建存储个人信息文件夹失败")
        }
    }
    
    //头像保存路径
    func headerImageSaveFile() -> String{
        
        let saveEmp : ZFSaveEmpModel = ZFSaveEmpModel.shareInstance();
        
        let emp_id = saveEmp.emp_id;
        
        let path : String = "\(FILE_STRING)/shopApp/\(emp_id)/empHeaderImage.png";
        
        return path;
    }
    
    //保存图片
    func saveEmpHeaderImage(headerImage: UIImage){
        
        
        let pathTo : String = self.headerImageSaveFile();
        
        let data = UIImagePNGRepresentation(headerImage)
        
        let isWriteSuccess : Bool = data.writeToFile(pathTo, atomically: true)
        
        if isWriteSuccess {
            println("员工头像写入成功")
        }else{
            println("员工头像写入失败")
        }
    }
    
    //查询默认路径下的员工头像
    func selectIsHeaderImage() -> UIImage?{
        
        let flie : String = self.headerImageSaveFile();
        
        if let data : NSData = NSData(contentsOfFile: flie) {
            
            return UIImage(data: data);
        }
        
        return nil;
    }
    
    //是否用户有自定义头像
    func selectIsHeaderImage(empId : Int) -> UIImage?{
        
        let flie : String = "\(FILE_STRING)/shopApp/\(empId)/empHeaderImage.png";
        
        if let data : NSData = NSData(contentsOfFile: flie) {
            
            return UIImage(data: data);
        }
        
        return nil;
    }
    
    //查询所有的用户信息
    func selectSaveEmp() -> Array<ZFSaveLoginEmpModel>?{
        
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var saveEmps : NSArray? = defaults.objectForKey(SAVE_EMPS_KEY) as? NSArray;
        
        if saveEmps != nil {
            
            var emps : Array<ZFSaveLoginEmpModel> = Array<ZFSaveLoginEmpModel>()
            
            for index in 0 ..< saveEmps!.count {
                //是否已存在登录信息
                let data : NSData = saveEmps![index] as! NSData
                let emp : ZFSaveLoginEmpModel = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! ZFSaveLoginEmpModel
                
                emps.append(emp)
            }
            return emps;
            
        }
        
        return nil;
    }
    
    //添加员工新状态信息
    func insertSaveEmp(saveEmp: ZFSaveLoginEmpModel){
        
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var saveEmpsData : NSMutableArray? = defaults.objectForKey(SAVE_EMPS_KEY) as? NSMutableArray;
        
        if saveEmpsData != nil {
            
            let saveEmpsModel : Array<ZFSaveLoginEmpModel>? = selectSaveEmp();
            
            // 判断是否已存在了此登录信息
            let saveEmpsSubscript : Int? = self.selectIsSaveEmp(saveEmpsModel!, saveEmp: saveEmp);
            
            if saveEmpsSubscript == nil {
                // 添加登录信息
                let data : NSData =  NSKeyedArchiver.archivedDataWithRootObject(saveEmp);
                saveEmpsData!.addObject(data)
            }else {
                
                let newsSaveEmpsData : NSMutableArray = NSMutableArray()
                newsSaveEmpsData.addObjectsFromArray(saveEmpsData! as [AnyObject])
                
                //删除原有单信息
                newsSaveEmpsData.removeObjectAtIndex(saveEmpsSubscript!);
                
                //将数据放到数组的第一个
                let data : NSData =  NSKeyedArchiver.archivedDataWithRootObject(saveEmp);
                newsSaveEmpsData.insertObject(data, atIndex: 0);
                
                saveEmpsData = newsSaveEmpsData;
                
            }

            
        }else {
            
            saveEmpsData = NSMutableArray()
            let data : NSData =  NSKeyedArchiver.archivedDataWithRootObject(saveEmp);
            saveEmpsData!.addObject(data)
        }
        
        //存储用户信息
        defaults.setObject(saveEmpsData!, forKey: SAVE_EMPS_KEY);
        //同步数据
        defaults.synchronize();
        
    }
    
    //是否已存在登录信息
    func selectIsSaveEmp(saveEmps : Array<ZFSaveLoginEmpModel>, saveEmp: ZFSaveLoginEmpModel) -> Int?{
        
        for index in 0 ..< saveEmps.count {
            //是否已存在登录信息
            let emp : ZFSaveLoginEmpModel = saveEmps[index];
            if emp.emp_id == saveEmp.emp_id {
                
                return index;
            }
            
        }
        return nil;
    }
   
}
