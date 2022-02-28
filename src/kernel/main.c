#include "console.h"

void kernel_main()
{
    init_vga(WHITE, BLACK);
    print_string("=)");
    print_new_line();
    print_string("Hi");
}