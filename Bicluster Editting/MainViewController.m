//
//  MainViewController.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "MainViewController.h"
#import "Utilities.h"
#import "BiclusterViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UITextField *leftNodesTextField;
    UITextField *rightNodesTextField;
    UITextField *probabilityTextField;
    UITextField *kLimitTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Main";
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Targets
-(void)generateButton:(UIButton *)sender{
    BiclusterViewController *biclusterViewController = [utilities mainStoryboardInstantiateViewControllerWithIdentifier:@"BiclusterViewController"];
    biclusterViewController.numberOfLeftNodes = leftNodesTextField.text;
    biclusterViewController.numberOfRightNodes = rightNodesTextField.text;
    biclusterViewController.probability = probabilityTextField.text;
    biclusterViewController.kLimit = kLimitTextField.text;
    [self.navigationController pushViewController:biclusterViewController animated:YES];
}
-(void)doneBarButton:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
}

#pragma mark - Helper Functions

-(void)setupView{
    
    // Toolbar
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    toolBar.barStyle = UIBarStyleDefault;
    [toolBar setTranslucent:YES];
    [toolBar setUserInteractionEnabled:YES];
    [toolBar sizeToFit];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneBarButton:)];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:@[spaceButton,doneBarButton] animated:NO];
    
    // LeftNodes TextField
    leftNodesTextField = [[UITextField alloc]init];
    [leftNodesTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:leftNodesTextField];
    
    NSLayoutConstraint *leftNodesTextFieldTopConstraint = [NSLayoutConstraint constraintWithItem:leftNodesTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:[utilities statusNavigationHeight] + 8];
    NSLayoutConstraint *leftNodesTextFieldLeadingConstraint = [NSLayoutConstraint constraintWithItem:leftNodesTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
    NSLayoutConstraint *leftNodesTextFieldTrailing = [NSLayoutConstraint constraintWithItem:leftNodesTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
    [self.view addConstraints:@[leftNodesTextFieldTopConstraint,leftNodesTextFieldLeadingConstraint,leftNodesTextFieldTrailing]];
    
    [leftNodesTextField setPlaceholder:@"# of Left Nodes"];
    [leftNodesTextField setInputAccessoryView:toolBar];
    [leftNodesTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // RightNodes TextField
    rightNodesTextField = [[UITextField alloc]init];
    [rightNodesTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:rightNodesTextField];
    
    NSLayoutConstraint *rightNodesTextFieldTopConstraint = [NSLayoutConstraint constraintWithItem:rightNodesTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:leftNodesTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:8];
    NSLayoutConstraint *rightNodesTextFieldLeadingConstraint = [NSLayoutConstraint constraintWithItem:rightNodesTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
    NSLayoutConstraint *rightNodesTextFieldTrailing = [NSLayoutConstraint constraintWithItem:rightNodesTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
    [self.view addConstraints:@[rightNodesTextFieldTopConstraint,rightNodesTextFieldLeadingConstraint,rightNodesTextFieldTrailing]];
    
    [rightNodesTextField setPlaceholder:@"# of Right Nodes"];
    [rightNodesTextField setInputAccessoryView:toolBar];
    [rightNodesTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Probability TextField
    probabilityTextField = [[UITextField alloc]init];
    [probabilityTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:probabilityTextField];
    
    NSLayoutConstraint *probabilityTextFieldTopConstraint = [NSLayoutConstraint constraintWithItem:probabilityTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rightNodesTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:8];
    NSLayoutConstraint *probabilityTextFieldLeadingConstraint = [NSLayoutConstraint constraintWithItem:probabilityTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
    NSLayoutConstraint *probabilityTextFieldTrailing = [NSLayoutConstraint constraintWithItem:probabilityTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
    [self.view addConstraints:@[probabilityTextFieldTopConstraint,probabilityTextFieldLeadingConstraint,probabilityTextFieldTrailing]];
    
    [probabilityTextField setPlaceholder:@"Probability"];
    [probabilityTextField setInputAccessoryView:toolBar];
    [probabilityTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    // KLimit TextField
    kLimitTextField = [[UITextField alloc]init];
    [kLimitTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:kLimitTextField];
    
    NSLayoutConstraint *kLimitTextFieldTopConstraint = [NSLayoutConstraint constraintWithItem:kLimitTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:probabilityTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:8];
    NSLayoutConstraint *kLimitTextFieldFieldLeadingConstraint = [NSLayoutConstraint constraintWithItem:kLimitTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
    NSLayoutConstraint *kLimitTextFieldFieldTrailing = [NSLayoutConstraint constraintWithItem:kLimitTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
    [self.view addConstraints:@[kLimitTextFieldTopConstraint,kLimitTextFieldFieldLeadingConstraint,kLimitTextFieldFieldTrailing]];
    
    [kLimitTextField setPlaceholder:@"k limit"];
    [kLimitTextField setInputAccessoryView:toolBar];
    [kLimitTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Generate Button
    UIButton *generateButton = [[UIButton alloc]init];
    [generateButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:generateButton];
    
    NSLayoutConstraint *generateButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:generateButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
    NSLayoutConstraint *generateButtonCenterYConstraint = [NSLayoutConstraint constraintWithItem:generateButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *generateButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:generateButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
    NSLayoutConstraint *generateButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:generateButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self.view addConstraints:@[generateButtonLeadingConstraint,generateButtonCenterYConstraint,generateButtonTrailingConstraint,generateButtonHeightConstraint]];
    
    [generateButton setTitle:@"Generate Random Bicluster" forState:UIControlStateNormal];
    [generateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [generateButton.layer setBorderWidth:1];
    [generateButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [generateButton.layer setCornerRadius:8];
    [generateButton setBackgroundColor:[UIColor greenColor]];
    [generateButton addTarget:self action:@selector(generateButton:) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
