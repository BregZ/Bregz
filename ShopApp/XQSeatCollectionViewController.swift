//
//  XQSeatCollectionViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

let reuseIdentifier = "SeatCell"

class XQSeatCollectionViewController: UICollectionViewController,UIActionSheetDelegate {
    
    let layoutItemW : CGFloat = 100                 //cell的宽
    
    let layoutItemH : CGFloat = 150                 //cell的高
    
    let layoutSectionInset : CGFloat = 20           //
    
    var refreshControl : UIRefreshControl!          //刷新器
    
    lazy var seats : Array<XQSeatModel> = {
        
        return Array<XQSeatModel>()
        
    }()
    
    lazy var shopAction : UIActionSheet = {
        let shopAction : UIActionSheet = UIActionSheet()
        
        shopAction.title = "请您选择"
        shopAction.delegate = self
        shopAction.addButtonWithTitle("点单")
        shopAction.addButtonWithTitle("退桌")
        shopAction.addButtonWithTitle("取消")
        shopAction.destructiveButtonIndex = 1
        shopAction.cancelButtonIndex = 2
        
        return shopAction
    }()     //提示
    
    
    
    init() {
        
        var layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSizeMake(layoutItemW, layoutItemH)
        
        layout.sectionInset = UIEdgeInsetsMake(layoutSectionInset, layoutSectionInset, layoutSectionInset, layoutSectionInset)
        
        super.init(collectionViewLayout: layout)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(XQSeatCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.setupCollectionView()
        
        self.addRefreshControl()
        
        self.reloadMenuData()
    }
    
    //设置collectionView属性
    func setupCollectionView() {
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
    }
    
    //添加刷新功能
    func addRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "正在刷新...")
        refreshControl.addTarget(self, action: "reloadMenuData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        self.collectionView?.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.seats.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! XQSeatCollectionViewCell
    
        // Configure the cell
        
        cell.seat = self.seats[indexPath.row]
    
        return cell
    }


    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let title : String = (collectionView.cellForItemAtIndexPath(indexPath) as! XQSeatCollectionViewCell).titleView.text!
        self.shopAction.title = "请您为 \(title) 选择"
        self.shopAction.showInView(self.view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.buttonTitleAtIndex(buttonIndex) == "点单" {
            let singlePointVC : XQSinglePointViewController = XQSinglePointViewController()
            singlePointVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(singlePointVC, animated: true)
            
        }else if actionSheet.buttonTitleAtIndex(buttonIndex) == "退桌" {
            println("退桌")
        }
        
    }
    
    //刷新数据
    func reloadMenuData(){
        self.refreshControl?.beginRefreshing()
        
        let request = XQAsynHttp.sendGetHttp("shopSeat.php?gain=getSeat", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                if jsonArray != nil {
                    
                    var array = Array<XQSeatModel>()
                    
                    
                    
                    for  dict in jsonArray! {
                        
                        let menuTitleModel = XQSeatModel.seatWithDict(dict as! NSDictionary)
                        
                        array.append(menuTitleModel)
                        
                    }
                    self.seats = array
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.collectionView?.reloadData()
                    })
                }
                
                
            } else {
                NSLog("error : %@", error)
                
                
            }
        }
        
        self.refreshControl?.endRefreshing()
    }

    
    
}
