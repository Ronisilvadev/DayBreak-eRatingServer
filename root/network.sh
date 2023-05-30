#!/bin/sh
tcpdump \
	ip \
	and not arp \
	and port not 8722 \
	and net not 8.8.8.8 \
	and port not 137 \
