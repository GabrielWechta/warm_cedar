#!/bin/bash
gdb -tui $1 \
  -ex "break main" \
  -ex "run" \
  -ex "set disassembly-flavor intel" \
  -ex "layout asm" \
  -ex "layout regs" \
  -ex "tui reg float"
	


