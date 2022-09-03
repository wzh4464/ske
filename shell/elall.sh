#!/bin/bash
# @Author: WU Zihan
# @Date:   2022-09-03 15:32:40
# @Last Modified by:   WU Zihan
# @Last Modified time: 2022-09-03 15:37:59
for f in $(find toPGM/resource/Tableware/pgm/ -iname "*.pgm"); do
  ./ELSDc/elsdc $f
done