#include <stdio.h>
unsigned int shift_lfsr(unsigned int v)
{
	/*
		config          : fibonacci
		length          : 16
		taps            : (15, 14, 13, 4)
		shift-amounts   : (1)
		shift-direction : left
	*/
	enum {
		length         = 16,
		tap_0          = 15,
		tap_1          = 14,
		tap_2          = 13,
		tap_3          =  4,
		shift_amount_0 =  1
	};
	typedef unsigned int T;
	const T zero = (T)(0);
	v = (
		(
			v << shift_amount_0
		) | (
			(
				(v >> (tap_0 - shift_amount_0)) ^
				(v >> (tap_1 - shift_amount_0)) ^
				(v >> (tap_2 - shift_amount_0)) ^
				(v >> (tap_3 - shift_amount_0))
			) & (
				~(~zero << shift_amount_0)
			)
		)
	);
	return v;
}

void print_bytes(void *p, size_t len)
{
    size_t i;
    printf("(");
    for (i = 0; i < len; ++i)
        printf("%02X", ((unsigned char*)p)[i]);
    printf(")");
}


int main(void)
{
	unsigned int v = 1;
	unsigned int random_bits= 0;
	int i = 0;
	while (i < 40) {
			v = shift_lfsr(v);
			random_bits = (v & 0xffff);
			printf("%x\n",v);
			i++;
	}
}
