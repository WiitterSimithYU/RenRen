//
//  fixViewController.h
//  RenRen
//
//  Created by tangxiaowei on 16/6/20.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fixViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,NSURLConnectionDataDelegate>
{
   
        NSMutableData * _buffer ;
  

    UITableView*_tableview;
    
}

@end
