//
//  Edge.h
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/11/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Edge : NSObject

@property Node *leftNode;
@property Node *rightNode;
@property BOOL exists;
@property float cValue;

@end
