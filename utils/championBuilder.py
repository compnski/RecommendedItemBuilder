#!/usr/bin/env python

from BeautifulSoup import *
import urllib2
import re

def clean(html):
    return html.replace("</![cdata[>","")

soup = BeautifulStoneSoup(clean(urllib2.urlopen("http://na.leagueoflegends.com/champions").read()))


champPattern = re.compile("/champions/(\d+)/(.+?)_(.+)")


def fixTitle(title):
    return title.replace("_"," ").title()

def link2tuple(link):
    (n, name, title) = champPattern.match(link).groups()
    return dict(id=n, name=fixTitle(name), title=fixTitle(title))

champs = [link2tuple(x.get('href')) for x in soup.findAll(
        **{"class":"lol_champion"})]

imageDownloadTemplate = ("http://na.leagueoflegends.com/sites/default/files/"
                         "game_data/1.0.0.128/content/champion/icons/%s.jpg")

import os

ASSET_DIR="../src/embeddedAssets/images/champions/"
if not os.path.exists(ASSET_DIR):
    os.mkdir(ASSET_DIR)

championXmlTemplate = """
  <champion>
    <id>%(id)s</id)
    <name>%(name)s</name>
    <title>%(title)s</title>
  </champion>"""
champFileTemplate="<champions>%s</champions"

def getChampImagePath(id):
    return os.path.join(ASSET_DIR, "%s.jpg" % id)

champXmlList = []
for champ in champs:
    if not os.path.exists(getChampImagePath(champ['id'])):
        imgData =urllib2.urlopen(imageDownloadTemplate % champ['id']).read()
        if imgData:
            with open(getChampImagePath(champ['id']), "w") as imgFile:
                imgFile.write(imgData)
        else:
            print "Failed to download image for %s" % champ
    champXmlList.append(championXmlTemplate % champ)

with open("../src/assets/champions.xml", "w") as champFile:
    champFile.write(champFileTemplate % "".join(champXmlList))

