//
//  MemoryManagerController.m
//  PJKnowledgeNotes
//
//  Created by 周鹏钜 on 2020/7/1.
//  Copyright © 2020 zhoupengju. All rights reserved.
//

#import "PJPerson.h"
#import "MemoryManagerController.h"

NSString *aaa = @"100";
static NSString *ccc = @"1000";

@interface MemoryManagerController ()

@end

@implementation MemoryManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *bbb = @"10";
//    static NSString *cccddd = @"10660";
//    PJLog(@"%p, %p", aaa, bbb);
//    PJLog(@"%p, %p", ccc, cccddd);
//
//    __strong PJPerson *person1;
//    __weak PJPerson *person2;
//    __unsafe_unretained PJPerson *person3; // 堆内存释放, 栈里面的地址还在, 这时候 用地址去访问 已经释放的内存 就会崩溃
//
//    PJLog(@"11111111111111111");
//
//    {
//        PJPerson *person = [[PJPerson alloc] init];
//        person1 = person;
//    }
//
//    PJLog(@"2222222222222222222");
//
//    PJLog(@"%p, %@", person1, person1);
    
    
//    NSMutableString *str = [NSMutableString stringWithFormat:@"123"];
//    [str appendString:@"456"];
    
    
    [self testStr];
}


- (void)testStr
{
//    PJLog(@"%p", aaa);
//    PJPerson *person = [[PJPerson alloc] init];
//    PJLog(@"%p", person);
    
    NSMutableString *mString = [NSMutableString string];
    PJLog(@"%p", mString);
    [mString setString:@"original"];
    PJLog(@"%p", mString);
    self.strCopy = mString;
    PJLog(@"%p", mString);
    self.strStrong = mString;
    
    PJLog(@"%p", mString);
    
//    strCopy = original,   0xbeee773c69a9158e
//    strStrong = original, 0x6000028f3ed0
//
//    strCopy = original,   0xbeee773c69a9158e
//    strStrong = changed, 0x6000028f3ed0
     
    PJLog(@"%@, %p", self.strCopy, self.strCopy); // strCopy = original
    PJLog(@"%@, %p", self.strStrong, self.strStrong); // strCopy = original
    
    [mString setString:@"changed"];
    PJLog(@"%p", mString);
    
    PJLog(@"%@, %p", self.strCopy, self.strCopy); // strCopy = original
    PJLog(@"%@, %p", self.strStrong, self.strStrong); // strCopy = changed
}

/**
 
 objc_object::rootDealloc()
 {
     if (isTaggedPointer()) return;  // fixme necessary?

     if (fastpath(isa.nonpointer  &&
                  !isa.weakly_referenced  &&
                  !isa.has_assoc  &&
                  !isa.has_cxx_dtor  &&
                  !isa.has_sidetable_rc))
     {
         assert(!sidetable_present());
         free(this);
     }
     else {
         object_dispose((id)this);
     }
 }
 
 
 struct SideTable {
     // 保证原子操作的自旋锁
     spinlock_t slock;
     // 引用计数的 hash 表
     RefcountMap refcnts;
     // weak 引用全局 hash 表
     weak_table_t weak_table;
 }

 struct weak_table_t {
     // 保存了所有指向指定对象的 weak 指针
     weak_entry_t *weak_entries;
     // 存储空间
     size_t    num_entries;
     // 参与判断引用计数辅助量
     uintptr_t mask;
     // hash key 最大偏移值
     uintptr_t max_hash_displacement;
 };
 
 */


@end
