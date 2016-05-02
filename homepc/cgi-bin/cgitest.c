#include <stdio.h>

int main(int argc, char **argv)
{
  printf("Content-type: text/html\n\n");
  printf("<html>\n");
  printf("<head>\n");
  printf("<title>CGI Test</title>\n");
  printf("</head>\n");
  printf("<body>\n");
  printf("<p>Cgi (in C) tested and passed.</p>\n");
  printf("</body>\n");
  printf("</html>\n");

  return 0;
}
