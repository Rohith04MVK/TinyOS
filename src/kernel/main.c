#include "vga.h"
#include "keyboard.h"

void kernel_main()
{
    init_vga(WHITE, BLACK);
    print_string("=)");
    print_new_line();
    print_string("Welcome to TinyOS");
    print_string("Type something: ");
    test_input();
}