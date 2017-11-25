import os
import re
import sys

temp = os.popen('./a.out 2>&1').read().strip().split('},')
# import pdb; pdb.set_trace()
# print temp[0][0]
# sys.argv[1]
for i in temp:
    match = re.search('kCGWindowName = \"(.*)\";', i)
    if match:
        pid = match.group(1)
        # import pdb; pdb.set_trace()
        if pid == sys.argv[1]:
            match = re.search('kCGWindowNumber = (\d+);', i)
            wid = match.group(1)
            print wid
            break
