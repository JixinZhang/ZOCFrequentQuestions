//
//  ViewControllerA.h
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerA : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *type;

@end
