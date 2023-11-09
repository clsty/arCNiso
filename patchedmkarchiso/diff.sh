#!/bin/bash
# 除 diff/patch 外，另一种补丁方案（据说主要是 Debian 在用）是 Quilt
cd $(dirname $0)
diff -uNr /usr/bin/mkarchiso ./mkarchiso >mkarchiso.patch
