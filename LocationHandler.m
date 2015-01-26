
#import "LocationHandler.h"
#import <KitLocate/KitLocate.h>
#import "AppDelegate.h"


@implementation LocationHandler


-(void)geofencesIn:(NSArray *)arrPOIList
{
    NSArray *arrarrPush = [KLGeneralUtilities requestPushManagementApprovalWithGeofences:arrPOIList];
    
    if (arrarrPush != nil && [arrarrPush objectAtIndex:0] != nil && [[arrarrPush objectAtIndex:0] count] >= 4)
    {
        
        NSString *strID = [[arrarrPush objectAtIndex:0] objectAtIndex:2];
        NSString *strMessage = [[arrarrPush objectAtIndex:0] objectAtIndex:3];
        
        NSString *strMegaMessage = [NSString stringWithFormat:@"%@ - %@", strID, strMessage];
        
        [KLGeneralUtilities createPushWithText:strMegaMessage ImageName:@"" IconBadge:0 SoundName:@""];
    } else {
        [KLGeneralUtilities createPushWithText:@"NO ACK" ImageName:@"" IconBadge:0 SoundName:@""];
    }
}

- (void)didSuccessInitKitLocate:(int)status
{
    NSLog(@"didSuccessInitKitLocate, status: %d",status);
}
- (void)didFailInitKitLocate:(int)error
{
    NSLog(@"didFailInitKitLocate, error: %d",error);
}

- (void)onChangeKitLocateUserID:(NSString*)userId
{
    NSLog(@"onChangeKitLocateUserID, new ID: %@",userId);
}

@end
