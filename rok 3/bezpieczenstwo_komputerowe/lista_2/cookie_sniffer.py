import pyshark
import re

cap = pyshark.LiveCapture(interface='wlo1')
file = open("worth_checking_out.txt", 'w')

for pkt in cap:
	if pkt.highest_layer == "HTTP":
		matched_lines = [line for line in str(pkt).split('\n') if "Cookie" in line]
		if len(matched_lines) != 0:
			print(pkt.highest_layer, "\tintresting!", pkt.ip.src, " to ", pkt.ip.dst)
			print(matched_lines)


