#!/usr/bin/env python
# -*- coding: utf-8 -*-

import urllib2, sys

url=sys.argv[1]
fetchr = urllib2.urlopen('http://clck.ru/--?url='+url)
reslt = fetchr.read()
print 'Short URL:', reslt