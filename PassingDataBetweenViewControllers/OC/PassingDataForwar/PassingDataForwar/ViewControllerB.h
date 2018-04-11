//
//  ViewControllerB.h
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerBDelegate <NSObject>



@end

@interface ViewControllerB : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, copy) NSString *textFieldContent;
@property (nonatomic, assign) BOOL hideTextField;
@property (nonatomic, assign) BOOL hideBackButton;

@end
