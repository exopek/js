# Version 1.1
import xml.etree.ElementTree as xml
import json
import sitemap_create as sit
from uuid import getnode as get_mac
import re
import pathlib
import thing_creator as thing
import sys

import time

isDebug = True  # Für Windows auf True setzen
if isDebug is False:  # Für den PKEV
    parser_path = "/pke_scripts/parser/"
    jsondb_path = "/var/lib/openhab2/jsondb/"
    mac = ''.join(re.findall('..', '%012x' % get_mac()))
else:
    parser_path = "/Users/js/Desktop/Apache24/pchk/"
    jsondb_path = "/Users/js/Desktop/Apache24/pchk/"
    mac = "02423da79a7e"

thingexists = False


# Beim Beenden und Auftreten von Fehlern wird diese Funktion aufgerufen
def beenden(errorcode):
    print(len(mod_dict), file=config)
    print(room_nmb, file=config)
    print(len(item_dict), file=config)
    if errorcode != 0:
        print("Fehlercode: " + str(errorcode), file=error)
    sys.exit(errorcode)


debug = open(parser_path + "debug.txt", "w", encoding="utf8", newline='\n')
config = open(parser_path + "config.txt", "w", encoding="utf8", newline='\n')
error = open(parser_path + "error.txt", "w", encoding="utf8", newline='\n')

class_item = "org.eclipse.smarthome.core.items.ManagedItemProvider$PersistedItem"
class_itemLink = "org.eclipse.smarthome.core.thing.link.ItemChannelLink"

FnctToChannel = dict(Ausg="output", Relais="relay", LED="led", Regler1="rvarsetpoint", Regler2="rvarlock")
FnctToItem = dict(Ausg="Dimmer", Relais="Switch", LED="Switch", Regler1="Number", Regler2="Switch")
FnctToFnctNames = dict(Ausg="Ausg.", Regler1="Ändere Regler", Regler2="Sperre Regler", Relais="Relais")  # , LED="LED")
PerToChannel = dict(B3I="binarysensor", PMI="binarysensor", GUS="binarysensor", BU4L="binarysensor", BMI="binarysensor",
                    GBL="binarysensor", BT4="binarysensor", B8H="binarysensor")
PerToItem = dict(B3I="Contact", PMI="Contact", GUS="Contact", BU4L="Contact", BMI="Contact", GBL="Contact",
                 BT4="Contact", B8H="Contact")
PerToNumber = dict(BMI=4, PMI_1=4, PMI_2=5, PMI_3=6, PMI_4=7, GUS=4, GUS_2=5, GUS_3=6, GUS_4=7, GBL=4, GBL_2=5, GBL_3=6,
                   GBL_4=7)


# Klasse Variable: Erfasst alle Variablen eines Moduls, werden zum Schluss zu Items verwandelt
class Var:
    def __init__(self, _type, _id, source, unit, channel="variable"):
        self.type = _type
        self.nr = _id
        self.srcType = source
        if 95 < int(source) < 100:
            if unit == "ScaleUnitTemperature":
                self.srcType = "254"
            elif unit == "ScaleUnitVolt":
                self.srcType = "300"
            elif unit == "ScaleUnitAmpere":
                self.srcType = "301"
        self.unit = unit
        self.channel = channel


# Klasse Module: Alle Module werden aus dem XML gelesen und ein Objekt erstellt. Wird zum Schluss zu Thing umgewandelt
class Mod:
    def __init__(self, name, etage, zimmer, firmware, serialno, modnr, segnr=0):
        self.name = name
        self.etage = etage
        self.zimmer = zimmer
        self.firmwareDate = firmware
        self.serialNo = serialno
        self.modNr = modnr
        self.segNr = segnr
        self.output = 0
        self.functions = set()
        self.isShutterOutput = False
        self.isShutterRelay = [False, False]
        self.relayComment = ["", "", "", "", "", "", "", ""]
        self.binarySensorComment = ["", "", "", "", "", "", "", ""]
        self.OutputComment = ["", "", "", ""]
        self.OutputMod = ["", "", "", ""]
        self.RegulatorComment = ["", ""]
        self.TCodeComment = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
        self.commentA1 = ""
        self.commentA2 = ""
        self.RegulatorUnit = ["", ""]

    # Output Enable(0), Disable(-1), Motor(1)
    def changeOutput(self, outputtype):
        self.output = outputtype

    # function of keytable were add to the module, not recommended for newest version
    def addFnct(self, function):
        self.functions.add(function)


# Klasse Funktionen: Ausgänge, Relais und Regler werden in Funktionen gespeichert und später als Item genutzt
class Function:
    def __init__(self, srcmod, destseg, destmod, ismod, _type, channel, _item, _name, icon, unit, label=None,
                 channel_nr=1,
                 value=0):
        self.srcId = srcmod
        self.destSeg = destseg
        self.destMod = destmod
        if ismod == "module":
            self.isModule = True
        else:
            self.isModule = False
        self.type = _type
        self.channel = channel
        self.item = _item
        self.name = _name
        if label is not None:
            self.label = label
        else:
            self.label = _name
        self.channelNr = channel_nr
        self.value = value
        self.unit = unit
        self.icon = icon


# Ersetzt die Abkürzungen aus der PRO-Xml Datei in Vollständige Namen
def name_replace(_name):
    if "KE" == _name.upper():
        _name = 'Keller'
    elif "EG" == _name.upper():
        _name = 'Erdgeschoss'
    elif 'OG' in _name.upper():
        _name = 'Obergeschoss'
    elif 'DB' in _name.upper():
        _name = 'Dachgeschoss'
    elif 'DG' in _name.upper():
        _name = 'Dachgeschoss'
    elif "WZ" == _name.upper():
        _name = _name.upper().replace('WZ', 'Wohnzimmer')
    elif 'SZ' in _name:
        _name = _name.replace('SZ', 'Schlafzimmer')
    elif 'AZ' in _name:
        _name = _name.upper().replace('AZ', 'Arbeitszimmer')
    elif 'HV' in _name:
        _name = _name.upper().replace('HV', 'Hauptverteilung')
    elif 'UV' in _name:
        _name = _name.upper().replace('UV', 'Unterverteilung')
    elif 'KIZI' in _name.upper():
        _name = _name.upper().replace('KIZI', 'Kinderzimmer')
    elif 'GZ' in _name:
        _name = _name.upper().replace('GZ', 'Gästezimmer')
    elif 'EZ' in _name:
        _name = _name.upper().replace('EZ', 'Esszimmer')
    elif 'HWR' in _name:
        _name = _name.upper().replace('HWR', 'Hauswirtschaftsraum')
    elif 'BZ' in _name:
        _name = _name.upper().replace('BZ', 'Badezimmer')
    elif 'BAD' in _name:
        _name = _name.upper().replace('BAD', 'Badezimmer')
    return _name


# Function if relay is used for rollershutter or only relay
def checkrelay(_fnct):
    if mod_dict.get(_fnct.destMod, "256") != "256":
        relay1and2 = False
        relay3and4 = False
        relay5and6 = False
        relay7and8 = False
        name_changed = False

        if int(_fnct.channelNr) <= 2:
            relay1and2 = True
        elif int(_fnct.channelNr) <= 4:
            relay3and4 = True
        elif int(_fnct.channelNr) <= 6:
            relay5and6 = True
        elif int(_fnct.channelNr) <= 8:
            relay7and8 = True

        if mod_dict.get(_fnct.destMod, "256").isShutterRelay[0] and relay1and2:
            _fnct.name = "Rollershutter"
            _fnct.channel = "rollershutterrelay"
            _fnct.item = "Rollershutter"
            _fnct.icon = "rollershutter"
            _fnct.channelNr = "1"
        elif mod_dict.get(_fnct.destMod, "256").isShutterRelay[0] and relay3and4:
            _fnct.name = "Rollershutter"
            _fnct.channel = "rollershutterrelay"
            _fnct.item = "Rollershutter"
            _fnct.icon = "rollershutter"
            _fnct.channelNr = "2"
        elif mod_dict.get(_fnct.destMod, "256").isShutterRelay[1] and relay5and6:
            _fnct.name = "Rollershutter"
            _fnct.channel = "rollershutterrelay"
            _fnct.item = "Rollershutter"
            _fnct.icon = "rollershutter"
            _fnct.channelNr = "3"
        elif mod_dict.get(_fnct.destMod, "256").isShutterRelay[1] and relay7and8:
            _fnct.name = "Rollershutter"
            _fnct.channel = "rollershutterrelay"
            _fnct.item = "Rollershutter"
            _fnct.icon = "rollershutter"
            _fnct.channelNr = "4"
    return _fnct


# guckt ob Kommando text das Schlüsselwort beinhaltet, wird in der aktuellen Version nicht verwendet
def fnct_check(_key, _text, _fnct_set, _destid):
    searchText = FnctToFnctNames.get(_key)
    if _text.find(searchText) != -1:
        _channel_number = "0"
        _fnct_value = "0"
        _check_exist = 0
        _channel_name = FnctToChannel.get(_key)
        _item_name = FnctToItem.get(_key)
        # channel number und weitere Informationen werden im commando text gesucht, je nach channel type ist der wo
        # anders zu finden
        # if _channel_name == "output":
        #    _channel_number = _text[_text.find(searchText) + len(searchText)]
        #    if _text.find("Flackern") != -1 or _text.find("Sperre") != -1:
        #        _check_exist = -1
        # elif _channel_name == "rvarsetpoint":
        #    if _text.find("abs") == -1:
        #        _channel_number = _text[_text.find(searchText) + len(searchText)]
        #        _fnct_value = abs(int(_text[(_text.rfind(")") + 2):len(_text)]))
        #    else:
        #        return [-1, -1, -1, -1, -1]
        # elif _channel_name == "relay":
        if _channel_name == "relay":
            _channel_number = _text[_text.find(":") + 2:_text.find(":") + 17].split(" ")

        return [_item_name, _channel_number, _channel_name, _fnct_value, _check_exist]
    else:
        return [-1, -1, -1, -1, -1]


# Überprüft ob in dem Raum das identische Item schon existiert
def checkDouble(_fnct, _item_fnct):
    if mod_dict.get(_fnct.destMod, "256") != "256":
        if _fnct.channel == _item_fnct.channel and mod_dict.get(_fnct.destMod, "256").serialNo == _item_fnct.serialNmb:
            if _fnct.channelNr == _item_fnct.channelnmb:
                return True


# Sucht in den Kommentaren des Moduls, falls Funktionen aus den Tastentabellen genutzt werden
def nameSearch(_cmd, _fnct, _taste, _table):
    if _cmd.get("comment") is not None:
        return _cmd.get("comment")
    elif _fnct.get("comment") is not None:
        return _fnct.get("comment")
    elif _taste.get("comment") is not None:
        return _taste.get("comment")
    elif _table.get("comment") is not None:
        return _table.get("comment")


# Überprüft, ob am Ausgang ein Rollershutter liegt und sucht das Label aus Kommentar
def checkOutput(_fnct):
    if mod_dict.get(_fnct.destMod, "256") != "256":
        _temp = 0
        if _fnct.name == "Ausg":
            if _fnct.channelNr == "1":
                _temp = 0
            elif _fnct.channelNr == "2":
                _temp = 1
            elif _fnct.channelNr == "3":
                _temp = 2
            elif _fnct.channelNr == "4":
                _temp = 3
        if mod_dict.get(_fnct.destMod, "256").OutputComment[_temp] != "":
            _fnct.label = mod_dict.get(_fnct.destMod, "256").OutputComment[_temp]
        if mod_dict.get(_fnct.destMod, "256").output == 1 and 1 <= int(_fnct.channelNr) <= 2:
            _fnct.name = "Rollershutter"
            _fnct.item = "Rollershutter"
            _fnct.icon = "rollershutter"
            _fnct.channel = "rollershutteroutput"
            _fnct.channelNr = "1"
    return _fnct


# Label und Einheit werden aus dem Reglerkommentaren heraus gezogen
def checkRegulator(_fnct):
    if mod_dict.get(_fnct.destMod, "256") != "256":
        if _fnct.channelNr == "1":
            _fnct.label = mod_dict.get(_fnct.destMod, "256").RegulatorComment[0]
            _fnct.unit = mod_dict.get(_fnct.destMod, "256").RegulatorUnit[0]
        elif _fnct.channelNr == "2":
            _fnct.label = mod_dict.get(_fnct.destMod, "256").RegulatorComment[1]
            _fnct.unit = mod_dict.get(_fnct.destMod, "256").RegulatorUnit[1]
    _fnct.icon = "regler"
    return _fnct


# change ID to id with length 3
def pchk(stringid):
    if len(stringid) == 1:
        return "00" + stringid
    elif len(stringid) == 2:
        return "0" + stringid
    else:
        return stringid


# erstellt ein Dictionary für Json mit allen Items, erstellt zudem ein Tag für das Alexa Binding
def writeJsonDictItem(_item, group):
    tag = ""
    if _item.count == -1:
        return None
    else:
        if _item.channel == "relay":
            tag = "Switchable"
        elif _item.channel == "output":
            if _item.art == "Dimmer":
                tag = "Lighting"
            elif _item.art == "Switch":
                tag = "Switchable"
        elif _item.channel == "rvarsetpoint":
            tag = "TargetTemperature"
        elif "rollershutter" in _item.channel:
            tag = "Blind"
        elif _item.channel == "variable":
            if _item.art == "Number:Temperature":
                tag = "CurrentTemperature"
            elif _item.icon == "humidity":
                tag = "CurrentHumidity"
            elif _item.art == "Number:LuminousFlux":
                tag = "LightSensor"
        elif _item.channel == "binarysensor":
            tag = "ContactSensor"
        return {_item.name.replace(' ', '_'): {'class': class_item,
                                               'value': {'groupNames': group, 'itemType': _item.art, 'tags': [tag],
                                                         'label': _item.label,
                                                         'category': _item.icon}}}


# erstellt ein Dictionary für Json mit allen Metadata
def writeJsonDictMetadata(_item):
    if _item.count == -1:
        return None
    else:
        return {"autoupdate:" + _item.name.replace(' ', '_'): {'class': "org.eclipse.smarthome.core.items.Metadata",
                                                               'value': {'key': {'segments': ["autoupdate",
                                                                                              _item.name]},
                                                                         'value': "true",
                                                                         'configuration': {}}}}


# erstellt ein Dictionary für Json mit allen Verbindungen zwischen Item und Thing
def writeJsonDictItemLink(_item, _nmb):
    if _item.count == -1:
        return None
    else:
        channeluid = _item.name + " -> lcn:module:" + mac + ":S" + pchk(_item.destSeg) + "M" + pchk(
            _item.destID) + ":" + \
                     _item.channel + "#" + str(int(_nmb))
        return {channeluid: {'class': class_itemLink,
                             'value': {'channelUID': {'segments': ["lcn", "module", mac,
                                                                   "S" + pchk(_item.destSeg) + "M" + pchk(_item.destID),
                                                                   _item.channel + "#" + str(int(_nmb))]},
                                       'configuration': {
                                           'properties': {'profile': "system:default"}},
                                       'itemName': _item.name}}}


var_dict = dict()
mod_dict = dict()
per_dict = dict()

channel_dict = dict()
item_dict = dict()
metadata_dict = dict()
fnct_dict = dict()
floors = dict()
room_nmb = 0

per_set = set()
var_set = set()
fnct_set = set()
name_temp = ["", ""]
outputmode = "native200"

# Versucht das hochgeladene XML File zu öffnen
try:
    tree = xml.parse(parser_path + "traumhaus.xml")
    root = tree.getroot()
except Exception as e:
    print("File does not exist", file=error)
    print("Exception: " + str(e), file=error)
    beenden(1)

# Beginn der Main Routine, auslesen der Xml Datei, unterteilen in Module und Inforamtionsfindung
try:
    debug.write("Anfang von allem\n")
    for segment in root.iter('Segment'):
        segId = segment.get('segmentId')
        for module in segment.iter('Module'):
            try:
                name = module.find('Name').text
                firmwareDate = module.get('firmwareDate')
                serialNo = module.get('serialNo')[:-2]
                modNr = module.get('moduleId')
                _name_temp = name.split(' ', 2)
                # Ab Pro version 6.9.0 werden bei den Modulen, deren Stufenmodus abgespeichert.
                # Diese ist essentiel für einen ordnungsgemäße Funktion
                # Der Name des Moduls wird herausgeparst. Es gibt die "Etagen" Kategorie und die "Raum"-Kategorie
                try:
                    is200Mode = module.find('PropertyList').find('OutputMode200').text
                except Exception as e:
                    print(
                        "Die Projektdatei wurde nicht mit der neusten Pro exportiert, bitte nehmen Sie eine Version ab 6.9.0",
                        file=error)
                    print("Exception: " + str(e), file=error)
                    beenden(4)
                if is200Mode == 'false':
                    outputmode = "native50"
                if len(_name_temp) < 2:
                    name_temp[0] = name_replace(_name_temp[0])
                    name_temp[1] = name_replace("Raum")
                    #name_temp[1] = name_replace(_name_temp[0])
                else:
                    name_temp[0] = name_replace(_name_temp[0])
                    name_temp[1] = name_replace(_name_temp[1])
                mod_temp = Mod(name, name_temp[0], name_temp[1], firmwareDate, serialNo, modNr, segId)
            except Exception as e:
                print("Modul (" + modNr + ") hat einen Namen im falschen Format", file=error)
                print("Exception: " + str(e), file=error)
                beenden(4)
            # wenn die Ausgänge als Motorsteuerung eingesetzt werden, wird eine Funktion erstellt für die Rolladensteuerung als Channel
            for output in module.iter("OutputPorts"):
                if (output.get('{http://www.w3.org/2001/XMLSchema-instance}type')) == "OutputPortsMotor":
                    mod_temp.changeOutput(1)
                elif (output.get('{http://www.w3.org/2001/XMLSchema-instance}type')) == "OutputPortsDisabled":
                    mod_temp.changeOutput(-1)
            mod_dict[modNr] = mod_temp
            for output in module.iter("Output"):
                if output.get('mode'):
                    mod_dict[modNr].OutputMod[int(output.get('id')) - 1] = output.get('mode')
            # wenn relays beschriftet worden sind, werden diese als Label genutzt
            for relayComment in module.iter("RelayComment"):
                if relayComment.text[0] != "!":
                    mod_dict[modNr].relayComment[int(relayComment.get("id"))] = relayComment.text
            # wenn binarysensoren angeschlossen sind, werden diese als Label genutzt
            for binarySensorComment in module.iter("BinarySensorComment"):
                if binarySensorComment.text[0] != "!":
                    mod_dict[modNr].binarySensorComment[int(binarySensorComment.get("id"))] = binarySensorComment.text
            # wenn binarysensoren angeschlossen sind, werden diese als Label genutzt
            for OutputComment in module.iter("OutputComment"):
                if OutputComment.text[0] != "!":
                    mod_dict[modNr].OutputComment[int(OutputComment.get("id"))] = OutputComment.text
            # wenn binarysensoren angeschlossen sind, werden diese als Label genutzt
            for RegulatorComment in module.iter("RegulatorComment"):
                if RegulatorComment.text[0] != "!":
                    mod_dict[modNr].RegulatorComment[int(RegulatorComment.get("id"))] = RegulatorComment.text
            # wenn binarysensoren angeschlossen sind, werden diese als Label genutzt
            for TCodeComment in module.iter("TCodeComment"):
                if TCodeComment.text[0] != "!":
                    mod_dict[modNr].TCodeComment[int(TCodeComment.get("id"))] = TCodeComment.text

            for shuttercontrol in module.iter("ShutterOn1-4"):
                if shuttercontrol.text == "true":
                    mod_dict[modNr].isShutterRelay[0] = True
            for shuttercontrol in module.iter("ShutterOn5-8"):
                if shuttercontrol.text == "true":
                    mod_dict[modNr].isShutterRelay[1] = True

            # sucht alle angeschlossenen Peripherien aus dem Modul, haben die Peripherien Binärkontakte werden Items angelegt
            # aber nur wenn ein Kommentar in der BinarySensorComment ist
            debug.write("Periphery\n")
            for periphery in module.iter('Periphery'):
                PerType = periphery.get('{http://www.w3.org/2001/XMLSchema-instance}type')
                for key in PerToChannel.keys():
                    if key in PerType:
                        if key == "PMI":
                            _ch_nmb = PerToNumber.get(PerType.split("PerType", 1)[1], 4)
                            if mod_dict[modNr].binarySensorComment[_ch_nmb - 1] != "":
                                per_set.add(sit.Item(key, PerToItem[key], "motion", "motion", serialNo, segId, modNr,
                                                     PerToChannel[key], _ch_nmb,
                                                     mod_dict[modNr].binarySensorComment[_ch_nmb - 1]))
                                break
                        elif key == "B3I":
                            for i in range(6, 9):
                                if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                    per_set.add(
                                        sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                 PerToChannel[key], i,
                                                 mod_dict[modNr].binarySensorComment[i - 1]))
                            else:
                                break
                        elif key == "BMI":
                            for i in range(4, 8):
                                if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                    per_set.add(
                                        sit.Item(key, PerToItem[key], "motion", "motion", serialNo, segId, modNr,
                                                 PerToChannel[key], i,
                                                 mod_dict[modNr].binarySensorComment[i - 1]))
                            else:
                                break
                        elif key == "GUS":
                            _ch_nmb = PerToNumber.get(PerType.split("PerType", 1)[1], 4)
                            if mod_dict[modNr].binarySensorComment[_ch_nmb - 1] != "":
                                per_set.add(sit.Item(key, PerToItem[key], "motion", "motion", serialNo, segId, modNr,
                                                     PerToChannel[key], _ch_nmb,
                                                     mod_dict[modNr].binarySensorComment[_ch_nmb - 1]))
                                break
                        elif key == "GBL":
                            _ch_nmb = PerToNumber.get(PerType.split("_", 1)[1], 4)
                            if mod_dict[modNr].binarySensorComment[_ch_nmb - 1] != "":
                                per_set.add(sit.Item(key, PerToItem[key], "motion", "motion", serialNo, segId, modNr,
                                                     PerToChannel[key], _ch_nmb,
                                                     mod_dict[modNr].binarySensorComment[_ch_nmb - 1]))
                                break
                        elif key == "BU4L":
                            if "bin2" in periphery.get("name"):
                                for i in range(5, 9):
                                    if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                        per_set.add(
                                            sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                     PerToChannel[key], i,
                                                     mod_dict[modNr].binarySensorComment[i - 1]))
                            elif "bin2" in periphery.get("name"):
                                for i in range(1, 5):
                                    if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                        per_set.add(
                                            sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                     PerToChannel[key], i,
                                                     mod_dict[modNr].binarySensorComment[i - 1]))
                            break
                        elif key == "BT4":
                            if "bin2" in periphery.get("name"):
                                for i in range(5, 9):
                                    if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                        per_set.add(
                                            sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                     PerToChannel[key], i,
                                                     mod_dict[modNr].binarySensorComment[i - 1]))
                            elif "bin" in periphery.get("name"):
                                for i in range(1, 5):
                                    if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                        per_set.add(
                                            sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                     PerToChannel[key], i,
                                                     mod_dict[modNr].binarySensorComment[i - 1]))
                            break
                        elif key == "B8H":
                            for i in range(1, 9):
                                if mod_dict[modNr].binarySensorComment[i - 1] != "":
                                    per_set.add(
                                        sit.Item(key, PerToItem[key], "window", "window", serialNo, segId, modNr,
                                                 PerToChannel[key], i,
                                                 mod_dict[modNr].binarySensorComment[i - 1]))
                            else:
                                break
            else:
                per_dict[modNr] = per_set
                per_set = set()
            debug.write("Variable\n")
            # In der Variablenliste der XML stehende Messwerte werden als Variablenobjekt oder
            # wenn es sich um Regler handelt, als Funktionsobjekt abgespeichert
            if int(mod_dict[modNr].firmwareDate[:2], 16) > 22:
                for variable in module.iter('Variable'):
                    if variable.get('{http://www.w3.org/2001/XMLSchema-instance}type') == "VariableAnalog":
                        var_set.add(Var(variable.get('{http://www.w3.org/2001/XMLSchema-instance}type'),
                                        str(int(variable.get("variableId")) + 1),
                                        variable.get('sourceType'), variable.get('scaleUnit')))
                    elif variable.get('{http://www.w3.org/2001/XMLSchema-instance}type') == "VariableRegulatorSetPoint":
                        # mod_dict[modNr].RegulatorUnit[int(variable.get("regulatorId"))] = variable.get('scaleUnit')
                        fnct_set.add(
                            Function(modNr, segId, modNr, "module", "", "rvarsetpoint", "Number", "Regler1", "regler",
                                     variable.get('scaleUnit'),
                                     mod_dict[modNr].RegulatorComment[int(variable.get("regulatorId"))],
                                     int(variable.get("regulatorId")) + 1, 1))
                else:
                    var_dict[modNr] = var_set
                    var_set = set()

            # geht alle Tastenkommandos durch und sucht nach den unterstützten Funktionen
            #        debug.write("Function\n")
            #        for table in module.iter("Table"):
            #            for taste in table.iter("Key"):
            #                for fnct in taste.iter("Fnct"):
            #                    for cmd in fnct.iter("Command"):
            #                        if cmd.text != "Unprogrammiert":
            #                            destSeg = fnct.get("destSeg")
            #                            destID = (fnct.get("destId"), modNr)[fnct.get("destId") == "0"]
            #                            for key in FnctToFnctNames:
            #                                [item_name, channel_number, channel_name, fnct_value, check_exist] = fnct_check(
            #                                    key,
            #                                    cmd.text,
            #                                    fnct_set, destID)
            #                                if check_exist == 0:
            #                                    _label = nameSearch(cmd, fnct, taste, table)
            #                                    fnct_set.add(Function(modNr, destSeg, destID,
            #                                                          fnct.get("destType"), cmd.get("type"),
            #                                                          channel_name, item_name, key, sit.fncttoicon.get(key), sit.fncttoicon.get(key), _label,
            #                                                          channel_number, fnct_value))

            # Je nachdem wie der Ausgang geschaltet ist, wird das Item zu einem Slider(AnAusPercentage) oder einem Switch(AnAus)
            # und als Funktionsobjekt gespeichert
            for i, ausg_label in enumerate(mod_dict[modNr].OutputComment, start=0):
                _item_name = "Switch"
                _key = "Ausg"
                if ausg_label != "":
                    if 'switch' in mod_dict[modNr].OutputMod[i] or mod_dict[modNr].output == 1:
                        _item_name = "Switch"
                        _item_icon = "switch"

                    elif "dimmer" in mod_dict[modNr].OutputMod[i]:
                        _item_name = "Dimmer"
                        _item_icon = "slider"
                    elif "PPC" in mod_dict[modNr].OutputMod[i]:
                        _item_name = "Dimmer"
                        _item_icon = "slider"
                    elif "disable" in mod_dict[modNr].OutputMod[i]:
                        break
                    else:
                        _temp = "The Mode is not supported: " + mod_dict[modNr].OutputMod[i] + "\n"
                        debug.write(_temp)
                        break
                    fnct_set.add(
                        Function(modNr, segId, modNr, "module", "", "output", _item_name, _key, _item_icon, _item_icon,
                                 ausg_label, str(i + 1)))

            for i, relayComments in enumerate(mod_dict[modNr].relayComment, start=0):
                if relayComments != "":
                    fnct_set.add(
                        Function(modNr, segId, modNr, "module", "", "relay", "Switch", "Relais", "switch", "switch",
                                 relayComments, str(i + 1)))

            fnct_dict[modNr] = fnct_set
            fnct_set = set()

    # Erstellen der Things (Gateway/PKEV und alle Module)
    thing_dict = dict()
    # Versuch das Passwort vom PCHK zu lesen aus Datei
    try:
        if isDebug is False:
            pass_file = open("/var/lib/lcnpchk/pass.txt", "r")
        else:
            pass_file = open("/Users/js/Desktop/Apache24/pchk/pass.txt", "r")
    except Exception as e:
        print("Passfile does not exist", file=error)
        print("Exception: " + str(e), file=error)
        beenden(3)
    login = pass_file.read()
    username = login.split("/")[0]
    password = login.split("/")[1]
    file = jsondb_path + "org.eclipse.smarthome.core.thing.Thing.json"
    with open(file, 'w', encoding='utf8', newline='\n') as file_thing:
        thing_dict.update(thing.gatewayJSON(mac, username, password, outputmode))  # Erstellen des PKEV Thing
        for module in mod_dict:
            thing_dict.update(
                thing.thingJSON(mac, pchk(mod_dict[module].segNr), pchk(mod_dict[module].modNr), mod_dict[module].name,
                                mod_dict[module].serialNo))  # Erstellen der Modul Things
        else:
            json.dump(thing_dict, file_thing, ensure_ascii=True, indent=2)

    if isDebug and pathlib.Path(file).exists():
        print(pathlib.Path(file).is_file())
        print(pathlib.Path(file).stat().st_size)
    if pathlib.Path(file).exists():
        thingexists = True
        with open(jsondb_path + "org.eclipse.smarthome.core.thing.Thing.json") as json_file:
            data = json.load(json_file)
    else:
        thingexists = False

    # sitemap

    for module in mod_dict:
        found_icon = False
        # Fügt das Module zu einer Etage/Raum hinzu
        if mod_dict[module].etage not in floors:  # Wenn Etage noch nicht vorhanden, dann füge die Etage hinzu und den Raum
            floors[mod_dict[module].etage] = (
                sit.Floor(mod_dict[module].etage, sit.floortoicon.get(mod_dict[module].etage, "Unbekannt")))
        for roomname in sit.roomtoicon.keys():
            if roomname in mod_dict[module].zimmer:
                room2 = sit.Room(mod_dict[module].zimmer, sit.roomtoicon.get(roomname))
                found_icon = True
                break
        if found_icon is False:
            room2 = sit.Room(mod_dict[module].zimmer, "Unbekannt")
        if (room2.name not in floors[mod_dict[module].etage].rooms) and (room2.name not in floors):  # Wenn Raum nicht Etage gleich ist und nicht schon als Raum in der Etage gibt
            floors[mod_dict[module].etage].add_room(room2)
            room_nmb += 1

        # Gibt es Variablen in den Modulen, werden diese jetzt den Räumen zugeordnet
        if module in var_dict:
            for _vars in var_dict[module]:
                if mod_dict[module].zimmer not in floors:  # Entweder den Raum einer Etage
                    if sit.varnrtoname.get(int(_vars.srcType), "") != "":
                        floors[mod_dict[module].etage].rooms[mod_dict[module].zimmer].add_item(
                            sit.Item(sit.varnrtoname.get(int(_vars.srcType), "").replace(" ", "_"),
                                     sit.vartoitem.get(_vars.type, ""),
                                     _vars.unit, sit.unittoicon.get(_vars.unit, ""),
                                     mod_dict[module].serialNo, mod_dict[module].segNr, module, _vars.channel,
                                     _vars.nr))
                else:  # Oder der Etage selbst
                    if sit.varnrtoname.get(int(_vars.srcType), "") != "":
                        floors[mod_dict[module].etage].add_item(
                            sit.Item(sit.varnrtoname.get(int(_vars.srcType), "").replace(" ", "_"),
                                     sit.vartoitem.get(_vars.type, ""),
                                     _vars.unit, sit.unittoicon.get(_vars.unit, ""),
                                     mod_dict[module].serialNo, mod_dict[module].segNr, module, _vars.channel,
                                     _vars.nr))
        if module in fnct_dict:
            for fnct in fnct_dict[module]:
                found_double = False
                if mod_dict.get(fnct.destMod, "256") != "256":
                    if fnct.isModule:
                        if fnct.channel == "relay":
                            fnct = checkrelay(fnct)
                        elif fnct.channel == "output":
                            fnct = checkOutput(fnct)
                        elif fnct.channel == "rvarsetpoint":
                            fnct = checkRegulator(fnct)
                            # print(fnct.srcId, fnct.destMod, fnct.type, fnct.channelNr)
                        if mod_dict[module].zimmer not in floors:
                            for item_fnct in floors[mod_dict[module].etage].rooms[mod_dict[module].zimmer].items:
                                if checkDouble(fnct, item_fnct):
                                    found_double = True
                                    break
                            if found_double:
                                continue
                            floors[mod_dict[module].etage].rooms[mod_dict[module].zimmer].add_item(
                                sit.Item(fnct.name, fnct.item, fnct.unit, fnct.icon, mod_dict[fnct.destMod].serialNo,
                                         mod_dict[fnct.destMod].segNr, fnct.destMod,
                                         fnct.channel, fnct.channelNr, fnct.label, fnct.value))
                        else:
                            for item_fnct in floors[mod_dict[module].etage].items:
                                if checkDouble(fnct, item_fnct):
                                    found_double = True
                                    break
                            if found_double:
                                continue
                            floors[mod_dict[module].etage].add_item(
                                sit.Item(fnct.name, fnct.item, fnct.unit, fnct.icon, mod_dict[fnct.destMod].serialNo,
                                         mod_dict[fnct.destMod].segNr, fnct.destMod,
                                         fnct.channel,
                                         fnct.channelNr, fnct.label, fnct.value))
        if module in per_dict:
            for periphery in per_dict[module]:
                if mod_dict[module].zimmer not in floors:
                    floors[mod_dict[module].etage].rooms[mod_dict[module].zimmer].add_item(periphery)
                else:
                    floors[mod_dict[module].etage].add_item(periphery)

    # itemlist
    debug.write("Itemlist\n")
    with open(jsondb_path + 'org.eclipse.smarthome.core.items.Item.json', 'w', encoding='utf8',
              newline='\n') as file_item:
        temp = None
        for floor in floors.values():
            for room in floor.rooms.values():
                for item in room.items:
                    temp = writeJsonDictItem(item, [])
                    if temp is not None:
                        item_dict.update(temp)
            for item in floor.items:
                temp = writeJsonDictItem(item, [])
                if temp is not None:
                    item_dict.update(temp)
        else:
            item_dict.update(writeJsonDictItem(sit.Item("Messwerte", "Group", "", "heating", "", "", "", "", ""), []))
            item_dict.update(writeJsonDictItem(sit.Item("Regulatoren", "Group", "", "regler", "", "", "", "", ""), []))
            item_dict.update(writeJsonDictItem(sit.Item("Schalter", "Group", "", "light", "", "", "", "", ""), []))
            item_dict.update(writeJsonDictItem(sit.Item("Kontakt", "Group", "", "window", "", "", "", "", ""), []))
            json.dump(item_dict, file_item, ensure_ascii=True, indent=2)

    debug.write("Metadata\n")
    with open(jsondb_path + 'org.eclipse.smarthome.core.items.Metadata.json', 'w', encoding='utf8',
              newline='\n') as file_metadata:
        temp = None
        for floor in floors.values():
            for room in floor.rooms.values():
                for item in room.items:
                    temp = writeJsonDictMetadata(item)
                    if temp is not None:
                        metadata_dict.update(temp)
            for item in floor.items:
                temp = writeJsonDictMetadata(item)
                if temp is not None:
                    metadata_dict.update(temp)
        else:
            json.dump(metadata_dict, file_metadata, ensure_ascii=True, indent=2)

    # itemchannellink
    debug.write("ItemChannelLink\n")
    with open(jsondb_path + 'org.eclipse.smarthome.core.thing.link.ItemChannelLink.json', 'w', encoding='utf8',
              newline='\n') as file_channel:
        temp = None
        for floor in floors.values():
            for room in floor.rooms.values():
                for item in room.items:
                    temp = writeJsonDictItemLink(item, item.channelnmb)
                    if temp is not None:
                        if thingexists:
                            for x in temp:
                                if "variable" in x and item.unit != "ScaleUnitNative":
                                    thing_name = x.split(" ")[-1].rsplit(":", 1)[0]
                                    channel_thing = int(x.rsplit("#")[-1]) + 41
                                    if thing_name in data:
                                        data[thing_name]["value"]["channels"][channel_thing]["configuration"][
                                            "properties"][
                                            "unit"] = sit.unittoLCNUnit.get(item.unit, "native")
                                elif "rvarsetpoint" in x and item.unit != "ScaleUnitNative":
                                    thing_name = x.split(" ")[-1].rsplit(":", 1)[0]
                                    channel_thing = int(x.rsplit("#")[-1]) + 53
                                    if thing_name in data:
                                        data[thing_name]["value"]["channels"][channel_thing]["configuration"][
                                            "properties"][
                                            "unit"] = sit.unittoLCNUnit.get(item.unit, "native")
                        channel_dict.update(temp)
            for item in floor.items:
                temp = writeJsonDictItemLink(item, item.channelnmb)
                if temp is not None:
                    if thingexists:
                        for x in temp:
                            if "variable" in x and item.unit != "ScaleUnitNative":
                                thing_name = x.split(" ")[-1].rsplit(":", 1)[0]
                                channel_thing = int(x.rsplit("#")[-1]) + 41
                                if thing_name in data:
                                    data[thing_name]["value"]["channels"][channel_thing]["configuration"][
                                        "properties"][
                                        "unit"] = sit.unittoLCNUnit.get(item.unit, "native")
                            elif "rvarsetpoint" in x and item.unit != "ScaleUnitNative":
                                thing_name = x.split(" ")[-1].rsplit(":", 1)[0]
                                channel_thing = int(x.rsplit("#")[-1]) + 53
                                if thing_name in data:
                                    data[thing_name]["value"]["channels"][channel_thing]["configuration"][
                                        "properties"][
                                        "unit"] = sit.unittoLCNUnit.get(item.unit, "native")
                    channel_dict.update(temp)
        else:
            if thingexists:
                with open(jsondb_path + 'org.eclipse.smarthome.core.thing.Thing.json', 'w') as outfile:
                    json.dump(data, outfile, ensure_ascii=False, indent=2)
            json.dump(channel_dict, file_channel, ensure_ascii=True, indent=2)
    debug.write("Sitemap\n")
    sit.create_sitemap(floors)
    debug.write("Habpanel\n")
    sit.create_habpanel(floors)
    if isDebug:
        print("ende")
    beenden(0)
except Exception as e:
    exc_type, exc_obj, exc_tb = sys.exc_info()
    print("Ein unbekannter Fehler ist aufgetaucht!", file=error)
    print("Fehler: " + str(e), file=error)
    print("Zeile: " + str(exc_tb.tb_lineno), file=error)
    beenden(2)
