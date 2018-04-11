//
//  ViewControllerB.m
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "ViewControllerB.h"
#import "PassingDataManager.h"

@interface ViewControllerB ()

@end

@implementation ViewControllerB
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField.hidden = self.hideTextField;
    self.backButton.hidden = self.hideBackButton;
    
    self.tipLabel.text = [NSString stringWithFormat:@"'%@' was come from previous page",self.textFieldContent];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *content = [userDefaults objectForKey:@"kPassingDataBetweenViewControllers"];
    self.userDefaultsLabel.text = content;
    self.singletonLabel.text = [PassingDataManager sharedManager].content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClicked:(id)sender {
    NSString *content = self.textField.text;
    if ([self.delegate respondsToSelector:@selector(viewController:didFinishEnteringItem:)]) {
        [self.delegate viewController:self didFinishEnteringItem:content];
    }
    
//    if (self.block) {
//        self.block(content);
//    }
    
    NSDictionary *info = @{@"content" : content};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPassingDataBetweenViewControllersNotification" object:info];
}

- (void)setTextFieldContent:(NSString *)textFieldContent {
    _textFieldContent = textFieldContent;
}
@end
