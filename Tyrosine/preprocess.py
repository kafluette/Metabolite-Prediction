#!/usr/bin/env python
import subprocess
import os

NEG_FILE = 'negative_train2.csv'
POS_FILE = 'positive_train2.csv'
ALL_FILE = 'all_train2.csv'
OUT_FILE = 'all_train2.torch'

data = []

def skipfirst(iter):
	next(iter)
	for item in iter:
		yield item.strip()

print "Loading positive samples ..."
with open(POS_FILE,'r') as pos_file:
	for line in skipfirst(pos_file):
		dats = line.split(',') + ['1']
		data.append(dats)

print "Loading negative samples ..."
with open(NEG_FILE,'r') as neg_file:
	for line in skipfirst(neg_file):
		dats = line.split(',') + ['0']
		data.append(dats)

print "Writing combined samples ..."
with open(ALL_FILE,'w') as all_file:
	for dat in data:
		all_file.write(','.join(dat)+'\n')

print "Converting to Torch7 format ..."
subprocess.call('/bin/bash /Users/kellanfluette/bin/csv2t7.sh {} {}'.format(ALL_FILE,OUT_FILE),shell=True)

print "Cleaning up ..."
os.unlink(ALL_FILE)

print "Done. Torch7 data is in: {}".format(OUT_FILE)