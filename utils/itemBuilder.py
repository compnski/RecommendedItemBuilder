#!/usr/bin/env python

"""
<items>
<item>
 <name>Abyssal Scepter</name>
 <id>3007</id>
 <description/>
 <components>
  <itemId>3006</itemId>
  <itemId>3008</itemId>
 </components>
 <cost>1050</cost>
</item>
...
</items>

"""

xmlFileTemplate = """<items>
%(itemsXml)s
</items>"""


itemTemplateXml = """<item>
 <name>%(name)s</name>
 <id>%(id)s</id>
 <description>%(description)s</description>
%(componentsStr)s
%(componentOfStr)s
 <cost>%(cost)s</cost>
</item>"""
componentTemplate = """<itemId>%s</itemId>"""


embedFileTemplate = """
// NOTE: This file is auto-generated. Do not make any changes you expect to last.
// Run itemBuilder.py to generate a new version

package com.dreamofninjas.rib
{
    import flash.display.Bitmap;
   
    public class ItemSpriteFactory {

        public static function GetItemById(id:int):ItemSprite {
            return new itemsById[id]();
        }

%(embedDefStr)s

       private static var itemsById:Object = {
%(itemsByIdStr)s
                                             };
       
   }
}"""

itemsByIdTemplate = "        %(id)s:  %(privClassName)s"

itemTemplateEmbed =  """        [Embed(source="embeddedAssets/images/items/%(id)s.gif")]
        private static var %(privClassName)s:Class;
"""
"""
        public static function get %(privClassName)s():Bitmap {
            return ItemSprite(%(id)s, new %(privClassName)s());
        }
"""

class SerializableItem(object):
    def __init__(self, id, name, description, cost, components):
        self.id = id
        self.name = name
        self.description = description
        self.components = components
        self.componentOf = []
        self.cost = cost
        self.privClassName = "ID%s" % id
        #self.className = name.replace(" ", "")

    def __str__(self):
        return itemTemplate % self

    @property
    def componentsStr(self):
        if not self.components:
            return "<components/>"
        return "<components>%s</components>" % "\n".join([componentTemplate % c for c in self.components])

    @property
    def componentOfStr(self):
        if not self.componentOf:
            return "<componentOf/>"
        return "<componentOf>%s</componentOf>" % "\n".join([componentTemplate % c for c in self.componentOf])


    def __getitem__(self, key):
        return getattr(self, key)

    def __repr__(self):
        return str(self)


class SpriteList(object):

    def __init__(self, itemMap):
        self.itemMap = itemMap
        for item in itemMap.itervalues():
            idComponents = []
            for i in item.components:                
                idComponents.append(itemMap[i].id)
                itemMap[i].componentOf.append(item.id)
            item.components = idComponents

    @property
    def itemsByNameStr(self):
        return str(dict((str(k), v['id']) for (k,v) in self.itemMap.items()))

    @property
    def itemsByIdStr(self):
        return ",\n".join(itemsByIdTemplate % item for item in self.itemMap.values())

    @property
    def embedDefStr(self):
        return "\n".join([itemTemplateEmbed % item for item in self.itemMap.values()])

    @property
    def itemsXml(self):
        return "\n".join([itemTemplateXml % item for item in self.itemMap.values()])

    def __getitem__(self, key):
        return getattr(self, key)

    def getEmbedFile(self):
        return embedFileTemplate % self

    def getMetadataFile(self):
        return xmlFileTemplate % self

def loadItems():
    import json
    with open("items.json") as itemJson:
        itemsList = json.loads(itemJson.read())
        with open("itemIds.txt") as itemIds:
            itemIdMap = dict([reversed([t.strip() for t in line.split("-")]) for line in itemIds.read().split("\n") if line])
    itemMap = {}
    for item in itemsList:
        if 'name' not in item:
            print "Item %s has no name" % item
            continue

        name = item['name']
        if name not in itemIdMap:
           print "Item %s not in itemIdMap" % name
           continue

        id = itemIdMap[name]

        item[id] = id
        itemMap[name] = SerializableItem(id, name, item['description'], item['cost'], item['components'])

    return itemMap

spriteList = SpriteList(loadItems())

open("ItemSpriteFactory.as", "w").write(spriteList.getEmbedFile())
open("items.xml", "w").write(spriteList.getMetadataFile())


