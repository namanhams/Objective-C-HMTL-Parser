//
//  HTMLNode+AttributedString.m
//  HttmlParserSample
//
//  Created by Pham Hoang Le on 14/10/15.
//  Copyright © 2015 Pham Hoang Le. All rights reserved.
//

#import "HTMLNode+AttributedString.h"

@implementation HTMLNode (AttributedString)

- (NSMutableAttributedString *) attributedString:(NSDictionary *(^)(HTMLNode *))attributesForNode {
    return [HTMLNode traverseNode:self attributesForNode:attributesForNode];
}

+ (NSMutableAttributedString *) traverseNode:(HTMLNode *)node attributesForNode:(NSDictionary *(^)(HTMLNode *))attributesForNode {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for(int i = 0; i < node.children.count; i++) {
        [string appendAttributedString:[self traverseNode:node.children[i] attributesForNode:attributesForNode]];
    }
        
    if(node.nodetype == HTMLTextNode && node.rawContents != nil)
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:node.rawContents]];
    
    // Apply attributes
    if(attributesForNode != nil) {
        NSDictionary *attributes = attributesForNode(node);
        if(attributes != nil)
            [string setAttributes:attributes range:NSMakeRange(0, string.length)];
    }
    
    return string;
}

@end
