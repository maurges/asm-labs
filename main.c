#include <stdio.h>
#include <inttypes.h>

void add_tap(uint64_t);
void set_length(uint64_t);
void set_base_lfsr(uint64_t);
uint64_t lfsr_next(void);

int main()
{
	uint64_t length = 16;
	set_length(length);
	add_tap(0);
	add_tap(2);
	add_tap(3);
	add_tap(5);
	uint64_t base = 0xace1;
	set_base_lfsr(base);
	uint64_t current = 0;
	int counter = 0;
	while (current != base)
	{
		current = lfsr_next();
		counter += 1;
	}
	printf("%d\n", counter);
	if (counter == (1u << length) -1)
	{
		printf("counter is exactly 2^%d - 1\n", length);
	}
	return 0;
}
