//
//  MyVC.h
//  RenRen
//
//  Created by Beyondream on 16/6/15.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "BaseVC.h"

@interface MyVC : BaseVC<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    UITableView*_tableview;
    
}


@end
