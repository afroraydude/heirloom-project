VPATH=..
OBJ = t10.o t6.o hytab.o n1.o n2.o n3.o n4.o n5.o \
	n7.o n8.o n9.o ni.o nii.o suftab.o afm.o unimap.o \
	mapmalloc.o version.o

FLAGS = -DUSG -DINCORE $(EUC) -I. -I.. -DMACDIR='"$(MACDIR)"' \
	-DFNTDIR='"$(FNTDIR)"' -DTABDIR='"$(TABDIR)"'

.c.o:
	$(CC) $(CFLAGS) $(WARN) $(CPPFLAGS) $(FLAGS) -c $<

all: troff

troff: $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) $(LIBS) -o troff

ta: draw.o ta.o
	$(CC) $(LDFLAGS) draw.o ta.o $(LIBS) -lm -o $@

makedev: makedev.o
	$(CC) $(LDFLAGS) makedev.o $(LIBS) -o $@

install:
	$(INSTALL) -c troff $(ROOT)$(BINDIR)/troff
	$(STRIP) $(ROOT)$(BINDIR)/troff
	$(INSTALL) -c -m 644 troff.1b $(ROOT)$(MANDIR)/man1b/troff.1b

clean:
	rm -f $(OBJ) draw.o ta.o makedev.o troff ta makedev core log *~

mrproper: clean

draw.o: draw.c
makedev.o: makedev.c dev.h
t10.o: t10.c ../tdef.h ../ext.h dev.h afm.h
t6.o: t6.c ../tdef.h dev.h ../ext.h afm.h unimap.h
unimap.o: unimap.h
ta.o: ta.c dev.h
hytab.o: ../hytab.c
mapmalloc.o: ../mapmalloc.c
n1.o: ../n1.c ../tdef.h ../ext.h ./proto.h
n2.o: ../n2.c ../tdef.h ./proto.h ../ext.h
n3.o: ../n3.c ../tdef.h ./proto.h ../ext.h
n4.o: ../n4.c ../tdef.h ./proto.h ../ext.h
n5.o: ../n5.c ../tdef.h ../ext.h
n7.o: ../n7.c ../tdef.h ./proto.h ../ext.h
n8.o: ../n8.c ../tdef.h ../ext.h
n9.o: ../n9.c ../tdef.h ./proto.h ../ext.h
ni.o: ../ni.c ../tdef.h ./proto.h
nii.o: ../nii.c ../tdef.h ./proto.h ../ext.h
suftab.o: ../suftab.c
version.o: ../version.c
afm.o: dev.h afm.h
