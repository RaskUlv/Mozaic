#!/usr/bin/env python
# -*- coding: utf-8 -*-

#arguments are: followers, friends, tweets and date

import urllib2, sys, xml.dom.minidom

twname=sys.argv[1]
twarg=sys.argv[2]
fetchr = urllib2.urlopen('http://twitter.com/users/show.xml?screen_name='+twname)
reslt = fetchr.read()

dom = xml.dom.minidom.parseString(reslt)
userNode = dom.firstChild

def twnode(nodenumber) :
	twNode = userNode.childNodes[nodenumber]
	tw_node_content = twNode.firstChild.toxml()
	return tw_node_content

if twarg == 'followers' :
	print '@'+twname, 'has', twnode(17), 'followers'
elif twarg == 'friends' :
	print '@'+twname, 'has', twnode(29), 'friends'
elif twarg == 'stat' :
	print '@'+twname, 'has', twnode(53), 'twitts'
elif twarg == 'date' :
	print '@'+twname, 'acccount was created:', twnode(31)
else :
	print 'unknown argument'