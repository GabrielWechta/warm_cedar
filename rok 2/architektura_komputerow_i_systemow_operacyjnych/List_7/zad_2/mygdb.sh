#!/bin/bash
gdb $1 \
  -ex "break _start" \
  -ex "run" \
  -ex "set disassembly-flavor intel" \
  -ex "layout asm" \
  -ex "layout regs" \
  -ex "focus cmd"
	


