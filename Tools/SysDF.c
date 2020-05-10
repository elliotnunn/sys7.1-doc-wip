// Quick and dirty code to populate the system data fork, consisting of:
// 1 block containing System STR 1, no length byte, padded out with spaces
// 1 block built from LoadPatches.a, via the RSRC 0 in LoadPatches.a.rsrc


#include <stdio.h>
#include <fcntl.h>
#include <types.h>
#include <osutils.h>
#include <files.h>
#include <resources.h>
#include <memory.h>
#include <errno.h>


main(argc,argv)

int   argc;
char  *argv[];

{
  short     refnum;
  Handle    CodeHandle;     /* Handle to code resource */
  long      SizeCode;       /* Size of the code */
  Ptr       CodePtr;        /* Pointer to the code */
  int       FileDescript;   /* The file descriptor of the data file */
  unsigned  NumBWritten;    /* Number of bytes written per write */
  unsigned  Total;          /* Total number of bytes written */

  if (argc != 3) {
    fprintf(stderr,"### SYNTAX: SysDF SystemFile LoadPatches.a.rsrc\n");
    return 1;
  }

  // First resource (Extract the guts of STR 0)
  refnum = openresfile(argv[1]);
  if (refnum < 0 ) {
    fprintf(stderr,"### ERROR : Resource file 1: %s can't be opened. err = %d.\n",argv[1],refnum);
    return 1;
  }
  CodeHandle = Get1Resource('STR ',0);
  if (CodeHandle == nil) {
    fprintf(stderr,"### ERROR : Code resource 1 not available. Err = %d\n",errno);
    return 1;
  }
  LoadResource(CodeHandle);    // Make sure the resource is loaded.
  HNoPurge(CodeHandle);        // Make sure it stays loaded.
  HLock(CodeHandle);           // Make sure it doesn’t move.

  SizeCode = **(unsigned char **)CodeHandle;
  CodePtr = *(Ptr *)CodeHandle + 1;

  FileDescript = creat(argv[1]);
  if (FileDescript < 0) {
    fprintf(stderr,"### ERROR : Data file: %s can't be opened. err = %d.\n",argv[1],errno);
  }

  Total = 0;
  while (Total < SizeCode) {
    NumBWritten = write(FileDescript,CodePtr,SizeCode);
    if (NumBWritten < 0) {
      fprintf(stderr,"### ERROR : Write err = %d.\n",errno);
      return 1;
    } else {
      Total = Total + NumBWritten;
    }
  }
  CloseResFile(refnum);

  // Pad out the block with spaces
  while (Total < 512) {
    NumBWritten = write(FileDescript," ",1);
    if (NumBWritten < 0) {
      fprintf(stderr,"### ERROR : Write err = %d.\n",errno);
      return 1;
    } else {
      Total = Total + NumBWritten;
    }
  }

  // Second resource (the LoadPatches code)
  refnum = openresfile(argv[2]);
  if (refnum < 0 ) {
    fprintf(stderr,"### ERROR : Resource file 2: %s can't be opened. err = %d.\n",argv[2],refnum);
    return 1;
  }
  CodeHandle = Get1Resource('RSRC',0); //copyright blah blah blah
  if (CodeHandle == nil) {
    fprintf(stderr,"### ERROR : Code resource 2 not available. Err = %d\n",errno);
    return 1;
  }
  LoadResource(CodeHandle);    // Make sure the resource is loaded.
  HNoPurge(CodeHandle);        // Make sure it stays loaded.
  HLock(CodeHandle);           // Make sure it doesn’t move.

  SizeCode = GetHandleSize(CodeHandle); //different to the above
  CodePtr = *(Ptr *)CodeHandle;

  Total = 0;
  while (Total < SizeCode) {
    NumBWritten = write(FileDescript,CodePtr,SizeCode);
    if (NumBWritten < 0) {
      fprintf(stderr,"### ERROR : Write err = %d.\n",errno);
      return 1;
    } else {
      Total = Total + NumBWritten;
    }
  }
  CloseResFile(refnum);

  close(FileDescript);
  return 0;
}
