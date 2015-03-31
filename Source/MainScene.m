#import "MainScene.h"
#import "TableScene.h"

@implementation MainScene
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
		
		CCButton *buttonGo = [CCButton buttonWithTitle:@"Go To Table" fontName:@"ArialMT" fontSize:30];
		buttonGo.label.color = [CCColor blackColor];
		buttonGo.position = ccp(0.5,0.5);
		buttonGo.positionType = CCPositionTypeNormalized;
		[buttonGo setTarget:self selector:@selector(goToTableScene)];
		[self addChild:buttonGo];
	}
	return self;
}

-(void)goToTableScene {
	[[CCDirector sharedDirector] replaceScene:[TableScene scene]];
}

-(void)dealloc {
	NSLog(@"dealloc called MainScene");
}

@end
