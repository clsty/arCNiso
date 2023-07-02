#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso makearchive: auto make archive file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
# 运行这个可以生成本项目的 tar ball 到 archive 下。
echo "开始打包。"
TIME1=`date +%Y%m%d-%H:%M:%S`
TIME1_s=`date +%s`

cd $(dirname $0)

git add .
git commit
mkdir -p archive
git archive -o archive/arCNiso-latest.tar.gz main

TIME2=`date +%Y%m%d-%H:%M:%S`
TIME2_s=`date +%s`
TIMEpass=$[ $TIME2_s - $TIME1_s ]
echo "打包结束。"
echo "开始于 $TIME1 -- 经过 $TIMEpass 秒 --> 结束于 $TIME2"
