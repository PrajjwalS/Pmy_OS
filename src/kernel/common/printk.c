typedef unsigned short uint16_t;

static volatile uint16_t* const VGA = (uint16_t*)0xB8000;
static uint16_t cursor = 0;

void set_cursor(uint16_t row, uint16_t col)
{
    cursor = row * 80 + col;
}

void printk(const char* s)
{
    while (*s) {
        VGA[cursor++] = (0x0F << 8) | *s++;
    }
}

void clear_screen()
{
    for (int i = 0; i < 80 * 25; i++)
        VGA[i] = (0x0F << 8) | ' ';

    cursor = 0;
}