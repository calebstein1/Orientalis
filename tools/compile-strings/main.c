#define BUFF_SIZE 32768

#include <stdio.h>
#include <stdbool.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Error: must supply a single strings file\n");
        return -1;
    }

    int fd;
    if ((fd = open(argv[1], O_RDONLY)) == -1) {
        perror("open");
        return -1;
    }

    char str[BUFF_SIZE] = {};
    char *str_ln = NULL;
    char buff[BUFF_SIZE] = {};
    char *buff_p = NULL;
    struct stat str_stat = {};
    bool first_done = false;
    fstat(fd, &str_stat);

    if (str_stat.st_size > BUFF_SIZE/4) {
        fprintf(stderr, "Error: strings file too large\nYou can try recompiling this tool with a higher BUFF_SIZE\n");
        return -1;
    }

    lseek(fd, 0, SEEK_SET);
    read(fd, str, str_stat.st_size);
    str[strlen(str)] = '\0';
    close(fd);

    strcpy(buff, "function load_strings() strings={");
    buff_p = &buff[strlen(buff)];
    str_ln = strtok(str, "\n");

    while (str_ln) {
        if (first_done) {
            str_ln = strtok(NULL, "\n");
            if (!str_ln) break;
        }
        if (*str_ln == '~') {
            if (!first_done) {
                strcpy(buff_p, "{");
                first_done = true;
            } else {
                strcpy(--buff_p, "},{");
            }
        } else {
            sprintf(buff_p, "\"%s\",", str_ln);
        }
        buff_p = &buff[strlen(buff)];
    }

    buff_p--;
    strcpy(buff_p, "}} end");

    printf("%s\n", buff);

    return 0;
}