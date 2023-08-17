# open-c3-gateway

# 说明

```
在一些环境下需要对访问进行更多的控制，可以安装该gateway来解决。

当前的功能为： 在不修改服务的情况下，通过gateway控制,如果用户在一定时间内没有操作平台，把用户进行登出处理。

可以处理的服务和openc3本身无关，当前配置适用于处理superset服务在5分钟内没有人操作把用户登出。不需要单独修改superset服务。

本服务需要在支持docker的服务器上进行安装。当前访问量比较小，用的文件作为标记处理。后面如果请求量大可以改成用redis。


```

# 安装

## 下载

```
下载本项目到 /data/open-c3-gateway
```

## 修改

### 修改cookie的key名称
```
conf/js/openc3gateway.js : 把session字符串改成sid
conf/lua/md5.lua         : 把session字符串改成sid
conf/nginx.conf          : 把session字符串改成sid

```

### 修改登录页面地址

```
conf/js/openc3gateway.js: 把 '/login/' 改成 '/#/login'
# 注: 这里的默认登录页一定要写对，否则可能会出现一直在跳转的情况
```

### 修改后段服务地址

```
conf/nginx.conf: nginx 文件的proxy_pass 字段
```

### 修改超时时间
```
bin/cron.pl 中的300,当前默认是300秒不操作就超时
```
### 修改缓存时间
```
bin/cron.pl 中的86400,当前默认只缓存一天内的数据进行处理，超过一天的自动清理。
```
### 修改读取的日志行数
```
bin/cron.pl 当前读取的是最后的5000行
```

### 修改服务端口
```
bin/start.sh    当前是7788
conf/nginx.conf 当前是7788
```

## 启动服务

```
cd /data/open-c3-gateway/bin && ./start.sh

```

## 添加定时任务

```
把/data/open-c3-gateway/bin/cron.pl 添加到crontab中，每分钟执行一次。
```
