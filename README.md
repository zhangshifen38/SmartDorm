# NEU-Software_Engineering-Project

## 介绍

智能宿舍管理系统（Intelligent dormitory management system）是2022-2023学年软件工程课的大作业，包含基于SpringBoot的后端以及与之配套的前端，拥有公告、请假、退宿、换宿、报修等功能。

## 软件架构

软件采用客户端-服务器模式，应用前后端分离架构。服务器组件同时为多个客户端组件提供服务。客户端向服务器发启服务请求，服务器将相应服务信息回应给客户端。此外，服务器持续监听来自客户端的请求。

## 安装教程

1.  编译后端Java项目，在服务器上部署，将SpringBoot配置文件中的数据库信息改成自己实际的数据库信息。
2.  导入数据库资源表。系统给定的用户中密码是字符串123456的MD5值。
3.  部署前端，把controller.js中后端的链接改为你部署的后端链接。
4.  打开并使用！

## 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request



