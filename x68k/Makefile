#
# Copyright (c) 2025 Yuichi Nakamura (@yunkya2)
#
# The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

all:

CROSS_COMPILE ?= m68k-xelf-

CC = $(CROSS_COMPILE)gcc
LD = $(CC)

GIT_REPO_VERSION=$(shell git describe --tags --always)

CFLAGS = -Wall -O3 -g $(INC) $(DEFS) -MMD -MP
CFLAGS += -DGIT_REPO_VERSION=\"$(GIT_REPO_VERSION)\"
LDFLAGS = $(LIBS) -Wl,-Map,$(@:.x=.map)
LIBS = -lsocket

INC += -I. -I../include -I../include/smb2
DEFS += -DHAVE_CONFIG_H -D_U_="__attribute__((unused))"
DEFS += -DNEED_GETLOGIN_R -DNEED_WRITEV -DNEED_READV

SAMPLES_ORG = \
	smb2-cat-async.c \
	smb2-cat-sync.c \
	smb2-ftruncate-sync.c \
	smb2-ls-async.c \
	smb2-put-async.c \
	smb2-put-sync.c \
	smb2-raw-stat-async.c \
	smb2-raw-getsd-async.c \
	smb2-readlink.c \
	smb2-lsa-lookupsids.c \
	smb2-lseek-sync.c \
	smb2-share-enum.c \
	smb2-share-info.c \
	smb2-stat-sync.c \
	smb2-truncate-sync.c \
	smb2-CMD-FIND.c \
	smb2-server-sync.c \

SAMPLES_SRC = $(subst -,,$(SAMPLES_ORG))

$(SAMPLES_SRC): $(addprefix ../examples/,$(SAMPLES_ORG))
	for f in $^; do \
		cp $$f ./$$(basename $$f | tr -d -); \
	done

SAMPLES = $(SAMPLES_SRC:.c=.x)

all: $(SAMPLES)

LIBSMB2 = libsmb2.a

LIBSMB2_OBJS = \
	aes.o \
	aes128ccm.o \
	alloc.o \
	asn1-ber.o \
	compat.o \
	dcerpc.o \
	dcerpc-lsa.o \
	dcerpc-srvsvc.o \
	errors.o \
	hmac.o \
	hmac-md5.o \
	init.o \
	libsmb2.o \
	md4c.o \
	md5.o \
	ntlmssp.o \
	pdu.o \
	sha1.o \
	sha224-256.o \
	sha384-512.o \
	smb2-cmd-close.o \
	smb2-cmd-create.o \
	smb2-cmd-echo.o \
	smb2-cmd-error.o \
	smb2-cmd-flush.o \
	smb2-cmd-ioctl.o \
	smb2-cmd-lock.o \
	smb2-cmd-logoff.o \
	smb2-cmd-negotiate.o \
	smb2-cmd-notify-change.o \
	smb2-cmd-oplock-break.o \
	smb2-cmd-query-directory.o \
	smb2-cmd-query-info.o \
	smb2-cmd-read.o \
	smb2-cmd-session-setup.o \
	smb2-cmd-set-info.o \
	smb2-cmd-tree-connect.o \
	smb2-cmd-tree-disconnect.o \
	smb2-cmd-write.o \
	smb2-data-file-info.o \
	smb2-data-filesystem-info.o \
	smb2-data-security-descriptor.o \
	smb2-data-reparse-point.o \
	smb2-share-enum.o \
	smb3-seal.o \
	smb2-signing.o \
	socket.o \
	spnego-wrapper.o \
	sync.o \
	timestamps.o \
	unicode.o \
	usha.o

LIBSMB2_OBJS += poll.o

OBJS = $(SAMPLES_SRC:.c=.o) $(LIBSMB2_OBJS)
DEPS = $(OBJS:.o=.d)

%.o: ../lib/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(LIBSMB2): $(LIBSMB2_OBJS)
	ar rcs $@ $^

%.x: %.o $(LIBSMB2)
	$(LD) -o $@ $^ $(LDFLAGS)

clean:
	-rm -f $(OBJS) $(DEPS) $(LIBSMB2) $(SAMPLES_SRC) $(SAMPLES) *.map *.elf

-include $(DEPS)

.PHONY: all clean
