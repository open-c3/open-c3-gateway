# open-c3-gateway


# 安装

## 下载

```
下载本项目到 /data/open-c3-gateway
```

## 修改

### 修改cookie的key名称
```
conf/js/openc3gateway.js : 把session字符串改成sid
conf/lua/md5.lua:  把session字符串改成sid
conf/nginx.conf: 把session字符串改成sid

```

### 修改登录页面地址

```
conf/js/openc3gateway.js: 把 '/login/' 改成 '/#/login'
```

### 修改后段服务地址

```
conf/nginx.conf: nginx 文件的proxy_pass 字段
```

### 修改超时时间
```
cron.pl 中的300,当前默认是300秒不操作就超时
```

### 修改读取的日志行数
```
bin/cron.pl 当前读取的是最后的5000行
```

### 修改服务端口
```
bin/start.sh  当前是7788
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
