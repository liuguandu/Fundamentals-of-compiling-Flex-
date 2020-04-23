# Fundamentals-of-compiling-Flex-
运行环境是linux。关于flex的安装、使用、以及语法规则的说明。请参考博文[linux下flex构造词法生成器(从安装到实现——傻瓜教程)](https://blog.csdn.net/weixin_43165068/article/details/105550886)
## demo1.l
此文件就是词法生成器代码
## lexdemo.yy.c
此文件是通过demo1.l编译生成的.c文件
## lexdemo
此文件是通过lexdemo.yy.c生成的可执行文件
## test.txt
此文件是测试代码，lexdemo可直接执行test.txt
## demo1.l文件已更新，修复了部分bug(大家可自行撰写TXT文件的测试代码)。
