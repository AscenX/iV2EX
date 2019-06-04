## iV2EX

其实刚开始我只是想写一个练手项目，学习Flutter

后来想，干脆写着玩，不如写出来用，由于自己经常逛V站，就写个V站客户端吧

本来想完成了再开源，可是工作忙，平时又懒，直接开源了鞭策一下自己

![](https://github.com/AscenX/AscenX.github.io/blob/backup/images/iv2ex.gif?raw=true)

### 版本更新

现在算是0.0.1 版本吧

简单完成了

1.帖子列表

2.部分帖子详情列表

3.部分个人信息界面 

现在存在的问题有

1.因为V站的接口不全，所以这个项目很多都是抓网页的数据，我对HTML解析还不熟，
在用的都是正则来匹配出需要的信息

2.帖子详情用了 markdown 库，发现原来很多网页端展示的内容用了 html的特殊处理，之后还是要用html来解析

3.使用了 RxDart ，但是在 RxDart 中没有像 ReactiveCocoa 中的 RACCommand 或者 像 RxSwift社区出的 Action这种东西，目前暂时都用了 Subject来代替


### 架构

整体使用 MVVM 架构
