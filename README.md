# phpenv项目

## 项目依赖
- docker 物理机上自行安装

## 该项目专为为php开发环境使用，包含以下技术栈
- 系统：CentOS7
- PHP版本: 8.1.19  
- nginx: 1.24.0 
- Redis: 5.0
- Mysql: 8.0
- mongodb: 6.0

## 布署
### 1. 将项目克隆到将要存入的位置，比如当前把项目存放于C:\Users\12923
 - 此处应记住当前项目的目录C:\Users\12923\php-develop-env，在第3步有用。
```shell
git clone git@github.com:zhousb138912/php-develop-env.git
```

### 2. 将docker镜象拉取到本地
```shell
docker pull zhousb138912/phpenv:1
```

### 3. 从镜像建立一个容器
- 其中注意，-v为物理机目录与容器目录的映射参数，如果想修改网站项目的目录（默认在php-develop-env/www下），就再增加一个目录映射-v 物理机目录:容器内部目录
```shell
docker run -itd --privileged --name phpenv -p 80:80 -p 6379:6379 -p 3306:3306 -p 27017:27017 -v C:\Users\12923\php-develop-env:/server  zhousb138912/phpenv:1 /usr/sbin/init
```

### 4. 进入到容器，执行初始化脚本
```shell
# 进入容器
docker exec -it phpenv /usr/bin/bash
cd /server
chmod +x ./init.sh
./init.sh
```

### 5. 给日志文件777权限
```shell
chmod 777 -R /server/log
```

### 6. 启动各服务
```shell
cd /server
chmod +x ./start.sh
./start.sh
```

### 7.修改mysql数据库用户名密码
- 在物理机本项目的目录地址下./php-develop-env/log/mysql8/mysql.log的日志里找到password关键字，后面就是登录密码
```shell
mysql -uroot -p
# 键入密码
xxxxxxxx
# 修改用户密码
alter user 'root'@'localhost' identified by 'root123456.R';
# 切换数据库
use mysql;
# 修改密码安全等级
set global validate_password.policy=0;
# 修改密码长度限制
set global validate_password.length=3;
# 更新root用户接受所有IP请求
update user set host="%" where user ="root";
# 更改为简单密码
ALTER user "root"@"%" IDENTIFIED WITH mysql_native_password BY "123456";
# 冲刷所有权限
flush privileges;
# 退出mysql
exit;
```
- 重启mysql
```shell
systemctl restart mysqld
```

### 8. 修改mongodb数据库
```shell
# 进入数据库
mongosh mongodb://127.0.0.1:27017
# 切换到admin库
use admin
#添加超级管理员用户名密码
db.createUser({user:'root',pwd:'123456',roles:[{role:'root',db:'admin'}]})
# 退出mongodb
```
- 重启mongodb
```shell
mongod -f /server/etc/mongodb6/mongodb.conf --shutdown
mongod -f /server/etc/mongodb6/mongodb.conf
```

## 添加网站项目
### 克隆其它PHP项目到本项目www目录中，再配置etc/nginx目录中的配置文件，就可以开始开发了



