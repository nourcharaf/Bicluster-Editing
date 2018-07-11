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
#import "Edge.h"

@interface BiclusterViewController ()

@end

@implementation BiclusterViewController{
    UIView *contentView;
    NSMutableArray *leftNodes;
    NSMutableArray *rightNodes;
    NSMutableArray *edges;
    
    NSMutableArray *leftNodeViews;
    NSMutableArray *rightNodeViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Bicluster";
    
    UIBarButtonItem *startBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(startButton:)];
    [self.navigationItem setRightBarButtonItem:startBarButtonItem];
    
    // Constants
    int n = [_numberOfLeftNodes intValue];
    int m = [_numberOfRightNodes intValue];
    
    // Initialize left nodes
    leftNodes = [[NSMutableArray alloc]init];
    for (int i = 0;i<n;i++){
        Node *leftNode = [[Node alloc]init];
        leftNode.nodeId = [NSString stringWithFormat:@"%d",i];
        leftNode.nodeEdges = [[NSMutableArray alloc]init];
        [leftNodes addObject:leftNode];
    }
    
    // Initialize right nodes
    rightNodes = [[NSMutableArray alloc]init];
    for (int j = 0;j<m;j++){
        Node *rightNode = [[Node alloc]init];
        rightNode.nodeId = [NSString stringWithFormat:@"%d",j];
        rightNode.nodeEdges = [[NSMutableArray alloc]init];
        [rightNodes addObject:rightNode];
    }
    
    // Initialize edges
    edges = [[NSMutableArray alloc]init];
    for (int i = 0;i<n;i++){
        for (int j = 0;j<m;j++){
            Edge *edge = [[Edge alloc]init];
            edge.leftNode = leftNodes[i];
            edge.rightNode = rightNodes[j];
            [edges addObject:edge];
        }
    }
    
    // Randomly Generate Edges, add edges to nodes only if they exist
    for (Edge *edge in edges){
        if ([utilities randomNumber] <= [_probability floatValue]){
            edge.exists = YES;
            [edge.leftNode.nodeEdges addObject:edge];
            [edge.rightNode.nodeEdges addObject:edge];
        }
        else{
            edge.exists = NO;
        }
    }
    
    [self setupView];
    [self drawEdges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Targets
-(void)startButton:(UIBarButtonItem *)sender{
    
    // Do itteration k times
    for (int i = 0;i<[_kLimit intValue];i++){
        
        // Set Edge CValues
        [self setEdgeCValues];
        
        // Sort Edges based on cValue (Ascending)
        [self sortEdges];
        
        // Pick edge with least cValue (must exist)
        Edge *edgeToDelete;
        for (Edge *edge in edges){
            if (edge.exists){
                edgeToDelete = edge;
                break;
            }
        }
        
        // Delete Edge, and remove edge from left and right nodes
        if (edgeToDelete){
            edgeToDelete.exists = NO;
            [edgeToDelete.leftNode.nodeEdges removeObject:edgeToDelete];
            [edgeToDelete.rightNode.nodeEdges removeObject:edgeToDelete];
        }
        
        // Redraw Edges (optional)
        [self drawEdges];
    }
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
        
        node.nodeView = nodeView;
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
        
        node.nodeView = nodeView;
        [nodeView setupView];
        [nodeView.nodeLabel setText:[NSString stringWithFormat:@"%@'",node.nodeId]];
        [rightNodeViews addObject:nodeView];
        
        lastRightView = nodeView;
    }
    
    // Bottom Constraint
    NSLayoutConstraint *lastViewBottomConstraint = [NSLayoutConstraint constraintWithItem:leftNodes.count > rightNodes.count ? lastLeftView : lastRightView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8];
    [contentView addConstraints:@[lastViewBottomConstraint]];
    
    // Layout
    [contentView layoutIfNeeded];
}
-(void)setEdgeCValues{
    // Calculate cValue of edges (Here based on Z factor)
    // High cValue means edge should exist, low cValue means edge should be deleted
    for (Edge *edge in edges){
        if (edge.exists){
            edge.cValue = (edge.leftNode.nodeEdges.count - 1)*(edge.rightNode.nodeEdges.count - 1);
        }
        else{
            edge.cValue = 0;
        }
    }
}
-(void)sortEdges{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cValue" ascending:YES];
    NSArray *sortedArray = [edges sortedArrayUsingDescriptors:@[sortDescriptor]];
    edges = [NSMutableArray arrayWithArray:sortedArray];
}
-(void)drawEdges{
    // Remove All Drawn Edges
    [self removeAllDrawnEdges];
    
    // Connect LeftNodeViews to RightNodeViews if they are neighbors
    for (Edge *edge in edges){
        NodeView *leftNodeView = edge.leftNode.nodeView;
        NodeView *rightNodeView = edge.rightNode.nodeView;
        if (edge.exists){
            [self connectNodeViews:leftNodeView rightNodeView:rightNodeView color:[UIColor blackColor]];
        }
        else{
            [self connectNodeViews:leftNodeView rightNodeView:rightNodeView color:[UIColor clearColor]];
        }
    }
}
-(void)connectNodeViews:(NodeView *)leftNodeView rightNodeView:(NodeView *)rightNodeView color:(UIColor *)color{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(leftNodeView.frame.origin.x + leftNodeView.frame.size.width, leftNodeView.frame.origin.y + leftNodeView.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(rightNodeView.frame.origin.x, rightNodeView.frame.origin.y + rightNodeView.frame.size.height/2)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [contentView.layer addSublayer:shapeLayer];
}
-(void)removeAllDrawnEdges{
    for (CALayer *layer in contentView.layer.sublayers){
        if ([layer isKindOfClass:[CAShapeLayer class]]){
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [layer removeFromSuperlayer];
            }];
        }
    }
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
