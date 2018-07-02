//
//  NodeView.h
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@interface NodeView : UIView

@property BOOL didSetupView;
@property UIView *circleView;
@property UILabel *nodeLabel;

@property Node *node;

-(void)setupView;

@end
