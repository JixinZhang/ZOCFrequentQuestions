//
//  ViewControllerB.h
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewControllerB;

@protocol ViewControllerBDelegate <NSObject>

- (void)viewController:(ViewControllerB *)controller didFinishEnteringItem:(NSString *)content;

@end

@interface ViewControllerB : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UILabel *userDefaultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *singletonLabel;

@property (nonatomic, copy) NSString *textFieldContent;
@property (nonatomic, assign) BOOL hideTextField;
@property (nonatomic, assign) BOOL hideBackButton;

@property (nonatomic, weak) id<ViewControllerBDelegate> delegate;
@property (nonatomic, copy) void (^block)(NSString *content);

@end
