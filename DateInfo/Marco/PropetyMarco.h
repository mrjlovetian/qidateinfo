//
//  PropetyMarco.h
//  LoveQi
//
//  Created by tops on 2018/2/23.
//  Copyright © 2018年 李琦. All rights reserved.
//

#ifndef PropetyMarco_h
#define PropetyMarco_h

#define MRJImage(imagename) [UIImage getImageByName:imagename]

#define MRJWeakSelf(type)  __weak typeof(type) weak##type = type;
#define MRJStrongSelf(type)  __strong typeof(type) type = weak##type;

#endif /* PropetyMarco_h */
