//
//  ViewControllerA.m
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "PassingDataManager.h"

@interface ViewControllerA ()<ViewControllerBDelegate, UITextFieldDelegate>

@end

@implementation ViewControllerA

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nextButton.enabled = NO;
    self.textField.delegate = self;
    self.panelView.hidden = YES;
    if ([self.type isEqualToString:@"Passing Data Back"]) {
        self.nextButton.enabled = YES;
        self.textField.hidden = YES;
        self.tipLabel.text = @"Click NEXT button.";
        
    } else if ([self.type isEqualToString:@"Passing Data UserDefaults"]) {
        self.panelView.hidden = NO;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *content = [userDefaults objectForKey:@"kPassingDataBetweenViewControllers"];
        self.userDefaulstLabel.text = content;
        self.singletonLabel.text = @"";
        
    } else if ([self.type isEqualToString:@"Passing Data Singleton"]) {
        self.panelView.hidden = NO;
        self.singletonLabel.text = [PassingDataManager sharedManager].content;
        
    } else if ([self.type isEqualToString:@"Passing Data Notification"])  {
        self.nextButton.enabled = YES;
        self.textField.hidden = YES;
        self.tipLabel.text = @"Click NEXT button. Input something in next page, then they'll show here.";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.title = titleString;
}
- (IBAction)nextButtonClicked:(UIButton *)sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerB *viewControllerB = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerB"];
    viewControllerB.textFieldContent = @"Input something here, then click BACK button. And it will  show in previous view.";
    if ([self.type isEqualToString:@"Passing Data Forward"]) {
        viewControllerB.textFieldContent = self.textField.text;
        viewControllerB.hideTextField = YES;
        viewControllerB.hideBackButton = YES;
    }else if ([self.type isEqualToString:@"Passing Data Back"]) {
        viewControllerB.delegate = self;
        
//        __weak __typeof__ (self)weakSelf = self;
//        viewControllerB.block = ^(NSString *content) {
//            weakSelf.tipLabel.text = content;
//        };
        
    } else if ([self.type isEqualToString:@"Passing Data UserDefaults"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.textField.text forKey:@"kPassingDataBetweenViewControllers"];
        [userDefaults synchronize];
        
    } else if ([self.type isEqualToString:@"Passing Data Singleton"]) {
        [PassingDataManager sharedManager].content = self.textField.text;
        
    } else if ([self.type isEqualToString:@"Passing Data Notification"])  {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleData:) name:@"kPassingDataBetweenViewControllersNotification" object:nil];
    }
    
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.nextButton.enabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.nextButton.enabled = textField.text.length;
}

#pragma mark - ViewControllerBDelegate

- (void)viewController:(ViewControllerB *)controller didFinishEnteringItem:(NSString *)content {
    self.tipLabel.text = content;
}

#pragma mark - Notification

- (void)handleData:(NSNotification *)notification {
    NSDictionary *info = notification.object;
    NSString *content = [info valueForKey:@"content"];
    self.tipLabel.text = content;
}

@end
