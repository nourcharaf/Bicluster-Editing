//
//  BiclusterViewController.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "BiclusterViewController.h"
#import "Utilities.h"
#import "Node.h"
#import "NodeView.h"

@interface BiclusterViewController ()

@end

@implementation BiclusterViewController{
    UIView *contentView;
    NSMutableArray *leftNodes;
    NSMutableArray *rightNodes;
    NSMutableArray *leftNodeViews;
    NSMutableArray *rightNodeViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Bicluster";
    
    // Constants
    int n = [_numberOfLeftNodes intValue];
    int m = [_numberOfRightNodes intValue];
    
    // Initialize Left Nodes
    leftNodes = [[NSMutableArray alloc]init];
    for (int i = 0;i<n;i++){
        Node *node = [[Node alloc]init];
        node.nodeId = [NSString stringWithFormat:@"%d",i];
        node.nodeNeighbors = [[NSMutableArray alloc]init];
        [leftNodes addObject:node];
    }
    
    // Initialize Right Nodes
    rightNodes = [[NSMutableArray alloc]init];
    for (int i = 0;i<m;i++){
        Node *node = [[Node alloc]init];
        node.nodeId = [NSString stringWithFormat:@"%d",i];
        node.nodeNeighbors = [[NSMutableArray alloc]init];
        [rightNodes addObject:node];
    }
    
    // Generate Neighbors Randomly
    for (int i = 0;i<leftNodes.count;i++){
        Node *leftNode = leftNodes[i];
        for (int j = 0;j<rightNodes.count;j++){
            Node *rightNode = rightNodes[j];
            if ([utilities randomNumber] <= [_probability floatValue]){
                [leftNode.nodeNeighbors addObject:rightNode];
                [rightNode.nodeNeighbors addObject:leftNode];
            }
        }
    }
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

-(void)setupView{
    // Scroll View
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:scrollView];
    
    NSLayoutConstraint *scrollViewTopConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *scrollViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *scrollViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *scrollViewBottomConstraint = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-[utilities safeAreaInsetsBottom]];
    [self.view addConstraints:@[scrollViewTopConstraint,scrollViewLeadingConstraint,scrollViewTrailingConstraint,scrollViewBottomConstraint]];
    
    [scrollView setAlwaysBounceVertical:YES];
    
    // Content View
    contentView = [[UIView alloc]init];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [scrollView addSubview:contentView];
    
    NSLayoutConstraint *contentViewTopConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *contentViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *contentViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *contentViewWidthConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.view addConstraints:@[contentViewTopConstraint,contentViewLeadingConstraint,contentViewTrailingConstraint,contentViewBottomConstraint,contentViewWidthConstraint]];
    
    // Left Node Views
    leftNodeViews = [[NSMutableArray alloc]init];
    UIView *lastLeftView = contentView;
    for (int i = 0;i<leftNodes.count;i++){
        Node *node = leftNodes[i];
        
        NodeView *nodeView = [[NodeView alloc]init];
        [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [contentView addSubview:nodeView];
        
        NSLayoutConstraint *nodeViewTopConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastLeftView attribute:i == 0 ? NSLayoutAttributeTop : NSLayoutAttributeBottom multiplier:1 constant:8];
        NSLayoutConstraint *nodeViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:8];
        NSLayoutConstraint *nodeViewWidthConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
        NSLayoutConstraint *nodeViewHeightConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nodeView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [contentView addConstraints:@[nodeViewTopConstraint,nodeViewLeadingConstraint,nodeViewWidthConstraint,nodeViewHeightConstraint]];
        
        nodeView.node = node;
        [nodeView setupView];
        [nodeView.nodeLabel setText:[NSString stringWithFormat:@"%@",node.nodeId]];
        [leftNodeViews addObject:nodeView];
        
        lastLeftView = nodeView;
    }
    
    // Right Node Views
    rightNodeViews = [[NSMutableArray alloc]init];
    UIView *lastRightView = contentView;
    for (int i = 0;i<rightNodes.count;i++){
        Node *node = rightNodes[i];
        
        NodeView *nodeView = [[NodeView alloc]init];
        [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [contentView addSubview:nodeView];
        
        NSLayoutConstraint *nodeViewTopConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastRightView attribute:i == 0 ? NSLayoutAttributeTop : NSLayoutAttributeBottom multiplier:1 constant:8];
        NSLayoutConstraint *nodeViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8];
        NSLayoutConstraint *nodeViewWidthConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
        NSLayoutConstraint *nodeViewHeightConstraint = [NSLayoutConstraint constraintWithItem:nodeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nodeView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [contentView addConstraints:@[nodeViewTopConstraint,nodeViewTrailingConstraint,nodeViewWidthConstraint,nodeViewHeightConstraint]];
        
        nodeView.node = node;
        [nodeView setupView];
        [nodeView.nodeLabel setText:[NSString stringWithFormat:@"%@'",node.nodeId]];
        [rightNodeViews addObject:nodeView];
        
        lastRightView = nodeView;
    }
    
    // Bottom Constraint
    NSLayoutConstraint *lastViewBottomConstraint = [NSLayoutConstraint constraintWithItem:leftNodes.count > rightNodes.count ? lastLeftView : lastRightView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8];
    [contentView addConstraints:@[lastViewBottomConstraint]];
    
    // Connect LeftNodeViews to RightNodeViews if they are neighbors
    [contentView layoutIfNeeded];
    for (int i = 0;i<leftNodeViews.count;i++){
        NodeView *leftNodeView = leftNodeViews[i];
        
        for (int j = 0;j<rightNodeViews.count;j++){
            NodeView *rightNodeView = rightNodeViews[j];
            
            if ([self areNeighborNodes:leftNodeView.node rightNode:rightNodeView.node]){
                [self connectNodeViews:leftNodeView rightNodeView:rightNodeView];
            }
        }
    }
}
-(BOOL)areNeighborNodes:(Node *)leftNode rightNode:(Node *)rightNode{
    
    for (int i = 0;i<leftNode.nodeNeighbors.count;i++){
        Node *neighborNode = leftNode.nodeNeighbors[i];
        if ([neighborNode.nodeId isEqualToString:rightNode.nodeId]){
            return YES;
        }
    }
    
    return NO;
}
-(void)connectNodeViews:(NodeView *)leftNodeView rightNodeView:(NodeView *)rightNodeView{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(leftNodeView.frame.origin.x + leftNodeView.frame.size.width, leftNodeView.frame.origin.y + leftNodeView.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(rightNodeView.frame.origin.x, rightNodeView.frame.origin.y + rightNodeView.frame.size.height/2)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [contentView.layer addSublayer:shapeLayer];
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
