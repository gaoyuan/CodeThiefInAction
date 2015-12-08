#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os,sys,re
for root, directories, files in os.walk('.'):
    for file in files:
        print file
        with open(file) as f:
            for line in f:
                if line.strip():
                    print line,
            