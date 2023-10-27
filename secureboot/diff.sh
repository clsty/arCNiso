#!/bin/bash
cd $(dirname $0)
diff -uNr /usr/bin/mkarchiso ./mkarchiso >mkarchiso.patch
