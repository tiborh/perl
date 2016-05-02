#include <stdio.h>
#include <unistd.h>

int main(int argc, char** argv) {
  char hostname[12];
  printf("return value of gethostname(hostname,12): %d\n",gethostname(hostname,12));
  printf("hostname: %s\n",hostname);

  return(0);
}
