
/*
 
 Copyright (c) 2013-2014 RedBearLab
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RBLProtocol.h"
#import "BLE.h"

@interface RBLControlViewController : UITableViewController <ProtocolDelegate>
{
    IBOutlet UITableView *tv;
    IBOutlet UILabel *countLabel;
    IBOutlet UILabel *totalCountLabel;
    IBOutlet UILabel *personalCountLabel;
    IBOutlet UIView *imageGroup;
    IBOutlet UIImageView *fatMan;
    IBOutlet UIImageView *fire01;
    IBOutlet UIImageView *fire02;
    IBOutlet UIImageView *fire03;
    int fatManStatus;
    int fireStatus;
    int soundRandomStatus;
    SystemSoundID fireSound;
    SystemSoundID hitSound;
}

@property (strong, nonatomic) BLE *ble;
@property (strong, nonatomic) RBLProtocol *protocol;
@property (strong, nonatomic) IBOutlet UIImageView *fireImage;

- (IBAction)stopCount:(id)sender;

-(void) processData:(uint8_t *) data length:(uint8_t) length;

@end
