//
//  TableScene.m
//  TableViewCrash
//
//  Created by Alex Ogorek on 3/31/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TableScene.h"
#import "MainScene.h"

@interface TableScene ()
@property (nonatomic, strong) CCTableView *tblScores;
@end

@implementation TableScene

+(CCScene*)scene
{
	return [[self alloc] init];
}

-(id)init
{
	if ((self=[super init]))
	{
		CGSize winSize = [[CCDirector sharedDirector] viewSize];
		
		CCNode *background = [CCNodeColor nodeWithColor:[CCColor whiteColor] width:winSize.width *5 height:winSize.height*5];
		background.anchorPoint = ccp(0.5,0.5);
		background.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:background z:-2];
		
		CCButton *buttonGo = [CCButton buttonWithTitle:@"Go To Main" fontName:@"ArialMT" fontSize:30];
		buttonGo.label.color = [CCColor blackColor];
		buttonGo.position = ccp(0.5,0.8);
		buttonGo.positionType = CCPositionTypeNormalized;
		[buttonGo setTarget:self selector:@selector(goToMain)];
		[self addChild:buttonGo];
		
		
		self.tblScores = [CCTableView node];
		self.tblScores.dataSource = self;
		[self addChild:self.tblScores];
		
		self.tblScores.contentSize = CGSizeMake(0.7, 0.4);
		CGFloat ratioX = (1.0 - self.tblScores.contentSize.width) * 0.8;
		CGFloat ratioY = (1.0 - self.tblScores.contentSize.height) / 2;
		self.tblScores.position = ccp(winSize.width * ratioX, winSize.height * ratioY);
		[self.tblScores reloadData];
	}
	return self;
}

-(CCTableViewCell*)tableView:(CCTableView *)tableView nodeForRowAtIndex:(NSUInteger)index
{
	CCTableViewCell* cell = [CCTableViewCell node];
	
	cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
	cell.contentSize = CGSizeMake(1, 40);
	
	// Color every other row differently
	CCNodeColor* bg;
	if	(index % 2 != 0) bg = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
	else bg = [CCNodeColor nodeWithColor: [CCColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
	
	bg.userInteractionEnabled = NO;
	bg.contentSizeType = CCSizeTypeNormalized;
	bg.contentSize = CGSizeMake(1, 1);
	[cell addChild:bg];
	
	CCLabelTTF *lblContent = [CCLabelTTF labelWithString:@"Content..." fontName:@"ArialMT" fontSize:16];
	
	lblContent.positionType = CCPositionTypeNormalized;
	lblContent.position = ccp((arc4random() % 100) / 100.f,0.5);
	
	lblContent.color = [CCColor colorWithRed:52/255.f green:73/255.f blue:94/255.f];
	
	[cell addChild:lblContent];
	return cell;
}

-(NSUInteger)tableViewNumberOfRows:(CCTableView *)tableView
{
	return 20;
}

-(float)tableView:(CCTableView *)tableView heightForRowAtIndex:(NSUInteger)index
{
	return 40.f;
}

-(void)goToMain
{
	//comment THIS LINE to cause NO dealloc call:
	//uncomment and dealloc WILL be called
	self.tblScores.dataSource = nil;
	
	[[CCDirector sharedDirector] replaceScene:[MainScene scene]];
}

-(void)dealloc {
	NSLog(@"dealloc called TableScene");
}

@end
