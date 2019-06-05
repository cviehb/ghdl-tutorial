#include <stdio.h>
#include <stdlib.h>

/* function call for simulation start */
extern int ghdl_main (int argc, char **argv);

int main(int argc, char *argv[])
{
  printf("Before the GHDL Sim Call ...\n");
  int status = ghdl_main(0, NULL);
  printf("Status of GHDL_Sim: %d\n", status);
  return 0;
}

