//
//  ViewControllerB.m
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "ViewControllerB.h"

@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField.hidden = self.hideTextField;
    self.backButton.hidden = self.hideBackButton;
    
    self.tipLabel.text = [NSString stringWithFormat:@"'%@' was come from previous page",self.textFieldContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClicked:(id)sender {
    
}

- (void)setTextFieldContent:(NSString *)textFieldContent {
    _textFieldContent = textFieldContent;
}
@end
