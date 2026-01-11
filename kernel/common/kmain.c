
void printk(const char*);
void set_cursor(unsigned short, unsigned short);
void clear_screen();

static void delay()
{
    for (volatile unsigned int i = 0; i < 100000000; i++);
}

void show_kernel_loading_bad_animation() {
    int fake_parts = 10;
    int row = 12;
    int col = 0;
    while (fake_parts) {
        set_cursor(row,col);
        printk("Loading kernel [");
        for (int i = 0; i < 10 - fake_parts; i++) {
            printk("#");
        }
        for (int i = 0; i < fake_parts; i++) {
            printk(" ");
        }
        printk("]");
        delay();
        fake_parts--;
    }

    clear_screen();
    set_cursor(12,0);
    printk("========================= PmyOS - KERNEL SAYS HELLO! =========================");
    
}

void kmain(void)
{
    show_kernel_loading_bad_animation();
    for (;;)
    {
        __asm__ volatile ("hlt");
    }
}