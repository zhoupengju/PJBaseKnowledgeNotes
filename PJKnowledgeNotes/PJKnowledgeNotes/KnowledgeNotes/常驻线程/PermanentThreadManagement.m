//
//  PermanentThreadManagement.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/6/23.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "PermanentThreadManagement.h"

@interface PermanentThreadManagement () <AVAudioPlayerDelegate>
{
    long long timeIndex;
}

@property (nonatomic, strong) dispatch_source_t timerGCD;

@end

@implementation PermanentThreadManagement

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self appResidentThreadManger];
    }
    return self;
}

-(void)appResidentThreadManger {
    
    [self creatTheTimer];
    
    [self creatBackgroundPlayVoice];
}

#pragma mark - 后台播放音乐 相关方法
- (void)creatBackgroundPlayVoice {

    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void) {
        
        NSError *audioSessionError = nil;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        if ([audioSession setCategory:AVAudioSessionCategoryPlayback error:&audioSessionError]){
            NSLog(@"Successfully set the audio session.");
        } else {
            NSLog(@"Could not set the audio session");
        }
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"noVoice" ofType:@"mp3"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        
        if (audioPlayer != nil){
            
            audioPlayer.delegate = self;
            
            [audioPlayer setNumberOfLoops:-1];
            
            if ([audioPlayer prepareToPlay] && [audioPlayer play]){
                
                NSLog(@"Successfully started playing...");
            } else {
                NSLog(@"Failed to play.");
            }
        }
    });
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

}

- (void)creatTheTimer {
    
    [self creatTimer];
    
    [self creatGCDTimer];
}

- (void)creatTimer {
    
    timeIndex = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(automaticTiming) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)creatGCDTimer {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timerGCD = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    _timerGCD = timerGCD;
    dispatch_source_set_timer(timerGCD, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timerGCD, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(timerGCD);
//            dispatch_async(dispatch_get_main_queue(), ^{
//        }
//        timeout--;
        
        NSLog(@"=======================");
        
    });
    dispatch_resume(timerGCD);
}

- (void)automaticTiming {
    
    timeIndex++;
    
    NSLog(@"----------------");
    
    NSDictionary *dictTimeIndex = @{@"timeIndex" : [NSString stringWithFormat:@"%lld", timeIndex]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeIndexFinishNotice" object:nil userInfo:dictTimeIndex];
}


@end
