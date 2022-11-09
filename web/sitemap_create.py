import re
floortoicon = dict(Keller="cellar", Erdgeschoss="groundfloor", Obergeschoss="firstfloor", Dachgeschoss="attic",
                   Dachboden="attic", Hauptverteilung="vk", Unterverteilung="vk",
                   Garage="garage", Garten="garden", Terasse="terrace")
roomtoicon = dict(Wohnzimmer="sofa", Flur="corridor", Küche="kitchen", Badezimmer="bath", Ankleidezimmer="changingroom",
                  Garage="garage", Hauptverteilung="vk", Unterverteilung="vk", Kinderzimmer="kidsroom_icon",
                  Schlafzimmer="bedroom", Gästezimmer="suitcase", Esszimmer="diningroom",
                  Hauswirtschaftsraum="pantry", Büro="office", Partyraum="party", Arbeitszimmer="office")
floornametoabk = dict(Keller="KE", Erdgeschoss="EG", Obergeschoss="OG", Dachgeschoss="DG")
vartoitem = dict(VariableAnalog="Number", VariableRegulatorSetPoint="Number", VariableThreshold="Number", )
unittoicon = dict(ScaleUnitTemperature="temperature", ScaleUnitPercent="humidity", ScaleUnitVolt="energy",
                  ScaleUnitMeterPerSec="wind", ScaleUnitNative="lcn", ScaleUnitLux="light", ScaleUnitDegree="wind",
                  ScaleUnitLuxT="light", ScaleUnitPPM="CarbonDioxide", ScaleUnitAmpere="energy")
unittoLCNUnit = dict(ScaleUnitTemperature="temperature", ScaleUnitPercent="humidity", ScaleUnitVolt="voltage",
                     ScaleUnitMeterPerSec="windspeed", ScaleUnitNative="native", ScaleUnitLux="light", ScaleUnitPPM="co2",
                     ScaleUnitDegree="angle", ScaleUnitLuxT="light", ScaleUnitAmpere="current")
unittodimension = dict(ScaleUnitTemperature="Temperature", ScaleUnitPercent="Dimensionless",
                       ScaleUnitVolt="ElectricPotential", ScaleUnitAmpere="ElectricCurrent",
                       ScaleUnitMeterPerSec="Speed", ScaleUnitNative="Dimensionless", ScaleUnitLux="LuminousFlux")
unittosign = dict(ScaleUnitTemperature="°C", ScaleUnitPercent="", ScaleUnitVolt="V",
                  ScaleUnitMeterPerSec="m/s", ScaleUnitNative="", ScaleUnitLux="lx", ScaleUnitPPM="ppm",
                  ScaleUnitDegree="°", ScaleUnitAmpere="mA")
itemtogroup = dict(relay="Schalter", output="Schalter", variable="Messwerte", rvarsetpoint="Regulatoren",
                   binarysensor="Kontakt")
varnrtoname = dict(
    [(0, "Zaehler"), (1, "Ausgang1"), (2, "Ausgang2"), (3, "Ausgang3"), (4, "Ausgang4"), (13, "Temperatur"),
     (66, "Temperatur"), (67, "Temperatur"), (88, "Helligkeit"), (89, "Helligkeit"),
     (90, "Helligkeit"), (91, "Helligkeit"), (96, "Analog1"), (97, "Analog2"), (98, "Analog3"),
     (99, "Analog4"), (104, "Temperatur WIH"), (105, "Wind WIH"), (106, "Licht Ost"), (107, "Licht_Sued"),
     (108, "Licht West"), (109, "Azimut WIH"), (110, "Elevation WIH"), (112, "Temperatur"), (113, "Helligkeit"),
     (114, "Helligkeit"), (115, "Helligkeit"), (116, "Temperatur"), (117, "Temperatur"),
     (118, "Temperatur"), (119, "Temperatur"), (120, "Helligkeit"), (122, "CO2"), (128, "S0 Verbrauch1"),
     (129, "S0 Verbrauch2"), (130, "S0 Verbrauch3"), (131, "S0 Verbrauch4"), (144, "Feuchtigkeit"),
     (145, "Taupunkt"), (146, "Feuchtigkeit"), (147, "Taupunkt"),
     (148, "Feuchtigkeit"), (149, "Taupunkt"), (150, "Feuchtigkeit"),
     (151, "Taupunkt"), (152, "Temperatur"), (224, "Temperatur"), (225, "Temperatur"),
     (226, "Helligkeit"), (227, "Helligkeit"), (228, "Enocean"), (229, "Enocean"),
     (230, "CO2"), (231, "Feuchtigkeit"), (254, "Temperatur"), (300, "Spannung"), (301, "Stromstärke")])

fncttoicon = dict(Ausg="slider", Relais="switch", LED="light", Rollershutter="rollershutter",
                  Regler1="regler", Regler2="regler_sperre")

channelToPanelType = dict(output="slider", relay="switch", led="switch", rvarsetpoint="knob",
                          rvarlock="switch", binarysensor="switch", rollershutteroutput="template",
                          rollershutterrelay="template", variable="dummy")
percentFnct = dict(ScaleUnitPercent="JS(percentage.js):")

itemnameset = set()
isDebug = True # Für Windows auf True setzen
if isDebug is False:
    sitemap_path = "/etc/openhab2/sitemaps/"
    parser_path = "/pke_scripts/parser/"
else:
    sitemap_path = "/Users/js/Desktop/Apache24/pchk/"
    parser_path = "/Users/js/Desktop/Apache24/pchk/"


sitemap = open(sitemap_path + "traumhaus.sitemap", "w", encoding="utf8", newline='\n')

habpanel = open(parser_path + "traumhaus.txt", "w", encoding="utf8", newline='\n')

ausg_set = list()
regler_set = list()
var_set = list()
contact_set = list()


def get_Name(objekt):
    return objekt.name


def get_Label(objekt):
    return objekt.label


def get_Floor(objekt):
    if objekt.name == "Keller":
        return "7"
    elif objekt.name == "Garten":
        return "6"
    elif objekt.name == "Terasse":
        return "5"
    elif objekt.name == "Garage":
        return "4"
    elif objekt.name == "Erdgeschoss":
        return "3"
    elif objekt.name == "Obergeschoss":
        return "2"
    elif objekt.name == "Dachboden":
        return "1"
    elif objekt.name == "Dachgeschoss":
        return "0"
    else:
        return objekt.name


# Openhab erlaubt nur a-zA-Z0-9_
def charCheck(_label):
    ret = _label.replace("ä", "ae").replace("ö", "oe").replace("ü", "ue").replace("ß", "ss")
    ret = re.sub(r"[\s\-]", "_", ret)
    ret = re.sub(r"[^a-zA-Z0-9_]", "", ret)
    if len(ret) > 0 and ret[-1] == "_":
        ret = ret[:-1]
    return ret


# Globale Daten für die Kachelansicht
class Gloabl:
    sizeXItem = "1"
    sizeYItem = "1"
    sizeXRoom = "1"
    sizeYRoom = "3"
    font_size = "24"
    regulator_size = "18"
    iconset = "eclipse-smarthome-classic"
    icon_sizeItem = "16"
    icon_sizeRoom = "64"
    useserverformat = "false"


rowIndexItem = 0
colIndexItem = 0
rowIndexRoom = 0
colIndexRoom = 0


# Klasse Raum: Umfasst den Namen des Raums, die enthaltenen Elemente und ob er eine Temperatur besitzt
class Room:
    def __init__(self, name, icon):
        self.name = name
        self.items = set()
        self.icon = icon
        self.hasTemperature = False

    # Funktion zum hinzufügen von Elementen, die Namen der Elemente müssen einmalig sein,
    # Die Elemente werden mit dem Typ, Raumname und dem Label aus dem Kommentar bezeichnet
    # Falls dann immer noch Elemente gleich heißen, wird hochgezählt
    # Desweiteren wird nur eine Temperaturvariable in einem Raum zugelassen
    def add_item(self, item):
        if item.count != -1:
            item.name = item.name + "_" + charCheck(self.name) + "_" + charCheck(item.label)
            if item.name not in itemnameset:
                self.items.add(item)
                itemnameset.add(item.name)
                if item.name == "Temperatur":
                    self.hasTemperature = True
            elif self.hasTemperature and item.name == "Temperatur":
                return
            else:
                item.count += 1
                if item.name == "Temperatur":
                    self.hasTemperature = True
                item.changeName(item.name.split('_')[0] + '_' + str(item.count))
                self.add_item(item)


# Klasse Element:  Umfasst alle Inforamtionem zum Element: Channelname, Channelnummer, Name, Label, Einheit, Icon, Modul
class Item:
    def __init__(self, name, art, unit, icon, serialno, destseg, destid, channel_name, number, label=None, value=0):
        if name is not None and art is not None:
            self.name = name
            if art == "Number":
                self.art = art + ":" + unittodimension.get(unit, "Dimensionless")
            else:
                self.art = art
            self.icon = icon
            self.unit = unit
            self.channelnmb = number
            self.channel = channel_name
            self.count = 0
            self.value = value
            self.serialNmb = serialno
            self.destID = destid
            self.destSeg = destseg
            if label is not None:
                self.label = label
            else:
                self.label = name
            self.group = [itemtogroup.get(self.channel, [])]
        else:
            self.count = -1

    def changeName(self, new):
        self.name = new


# Klasse Etage: identisch zu Klasse Raum, umfasst desweiteren eine Liste von Raumobjekten
class Floor:
    def __init__(self, name, icon):
        self.name = name
        self.icon = icon
        self.rooms = dict()
        self.items = set()
        self.hasTemperature = False

    def add_room(self, room):
        self.rooms[room.name] = room

    def add_item(self, item):
        if item.count != -1:
            item.name = item.name + "_" + charCheck(self.name) + "_" + charCheck(item.label)
            if item.name not in itemnameset:
                self.items.add(item)
                itemnameset.add(item.name)
                if item.name == "Temperatur":
                    self.hasTemperature = True
            elif self.hasTemperature and item.name == "Temperatur":
                return
            else:
                item.count += 1
                if item.name == "Temperatur":
                    self.hasTemperature = True
                item.changeName(item.name.split('_')[0] + '_' + str(item.count))
                self.add_item(item)


# Überprüft ob die Etage Räume mit Elementen hat oder ob in der Etage selbst sich Elemente befinden
def floor_check(_floor):
    if len(_floor.rooms) != 0:
        for _room in _floor.rooms.values():
            if len(_room.items) != 0:
                return True
    elif len(_floor.items) != 0:
        return True
    else:
        return False


# Erstellen der Sitemap/Listenansicht für PKEV/Openhab
def create_sitemap(floors):
    sorted_floors = sorted(floors.values(), key=get_Floor)
    sitemap.write("sitemap traumhaus label=\"Traumhaus\"\n{\n")
    for floor in sorted_floors:
        if floor_check(floor):
            sitemap.write("    Frame label=\"" + floor.name + "\" icon=" + floor.icon + " {\n")
            # alle items aus den Zimmern
            sorted_rooms = sorted(floor.rooms.values(), key=get_Name)
            for room in sorted_rooms:
                if len(room.items) != 0:
                    sitemap.write(
                        "        Text label=\"" + room.name + "\" icon=" + room.icon + " { //" + floor.name + "\n")
                    sitemap.write("            Default item=Unsichtbar label=\"Unsichtbar\" \n")
                    sorted_items = sorted(room.items, key=get_Label)
                    for item in sorted_items:
                        if item.channel == "rvarsetpoint":  # Regler
                            sitemap.write("            Setpoint item=" + item.name + " label=\"" + item.label +
                                          " [" + percentFnct.get(item.unit, "") + "%.1f " + unittosign.get(item.unit, "") + "]\" step=" + str(item.value) + " icon=" + item.icon + "\n")
                            regler_set.append([item, room.name])
                        elif item.channel == "variable":  # Variable
                            sitemap.write("            Default item=" + item.name + " label=\"" + item.label +
                                          " [" + percentFnct.get(item.unit, "") + "%.1f " + unittosign.get(item.unit, "") + "]\"" + " icon=" + item.icon + "\n")
                            var_set.append([item, room.name])
                        elif item.channel == "output":  # Ausgang
                            if item.icon == "switch":  # Schalter
                                sitemap.write("            Switch item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                            elif item.icon == "slider":  # Dimmer
                                sitemap.write("            Slider item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                            ausg_set.append([item, room.name])
                        elif item.channel == "relay":  # Relais
                            sitemap.write(
                                "            Switch item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                            ausg_set.append([item, room.name])
                        elif "rollershutter" in item.channel:  # Rollladen
                            sitemap.write(
                                "            Default item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                            ausg_set.append([item, room.name])
                        elif item.channel == "binarysensor":  # Binärkontakt
                            sitemap.write(
                                "            Default item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                            contact_set.append([item, room.name])
                        else:
                            sitemap.write(
                                "            Default item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                    sitemap.write("        }\n")
            # alle items aus den Geschossen
            sorted_items = sorted(floor.items, key=get_Label)
            for item in sorted_items:
                if item.channel == "rvarsetpoint":  # Regler
                    sitemap.write("            Setpoint item=" + item.name + " label=\"" + item.label +
                                  " [" + percentFnct.get(item.unit, "") + "%.1f " + unittosign.get(item.unit, "") + "]\" step=" + str(item.value) + " icon=" + item.icon + "\n")
                    regler_set.append([item, floor.name])
                elif item.channel == "variable":  # Variable
                    sitemap.write("            Text item=" + item.name + " label=\"" + item.label +
                                  " [" + percentFnct.get(item.unit, "") + "%.1f " + unittosign.get(item.unit) + "]\" " + " icon=" + item.icon + "\n")
                    var_set.append([item, floor.name])
                elif item.channel == "output":  # Ausgang
                    if item.icon == "switch":  # Schalter
                        sitemap.write(
                            "            Switch item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                    elif item.icon == "slider":  # Dimmer
                        sitemap.write(
                            "            Slider item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                    ausg_set.append([item, floor.name])
                elif item.channel == "relay":  # Relais
                    sitemap.write(
                        "            Switch item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
                    ausg_set.append([item, floor.name])
                else:
                    sitemap.write(
                        "            Default item=" + item.name + " label=\"" + item.label + "\" icon=" + item.icon + "\n")
            sitemap.write("    }\n")
    # alle Schalter, Regulatoren, Relays, und Kontakte als Gruppe
    sitemap.write("    Frame {\n")
    if len(ausg_set) != 0:
        sitemap.write("        Text label=\"Schalter\" icon=switch {\n")
        sitemap.write("            Default item=Unsichtbar label=\"Unsichtbar\" \n")
        for se in ausg_set:
            if se[0].channel == "output":
                sitemap.write(
                    "            Slider item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] + "\" icon=" + se[0].icon + "\n")
            elif se[0].channel == "relay":
                sitemap.write(
                    "            Switch item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] + "\" icon=" + se[0].icon + "\n")
            else:
                sitemap.write(
                    "            Default item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] + "\" icon=" + se[0].icon + "\n")
        sitemap.write("        }\n")
    if len(var_set) != 0:
        sitemap.write("        Text label=\"Messwerte\" icon=temperature {\n")
        sitemap.write("            Default item=Unsichtbar label=\"Unsichtbar\" \n")
        for se in var_set:
            sitemap.write("            Text item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] +
                          " [" + percentFnct.get(se[0].unit, "") + "%.1f " + unittosign.get(se[0].unit, "") + "]\" " + " icon=" + se[0].icon + "\n")
        sitemap.write("        }\n")
    if len(regler_set) != 0:
        sitemap.write("        Text label=\"Regulatoren\" icon=regler {\n")
        sitemap.write("            Default item=Unsichtbar label=\"Unsichtbar\" \n")
        for se in regler_set:
            sitemap.write("            Setpoint item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] +
                          " [" + percentFnct.get(se[0].unit, "") + "%.1f " + unittosign.get(se[0].unit, "") + "]\" step=" + str(se[0].value) + " icon=" + se[0].icon + "\n")
        sitemap.write("        }\n")
    if len(contact_set) != 0:
        sitemap.write("        Text label=\"Kontakte\" icon=contact {\n")
        sitemap.write("            Default item=Unsichtbar label=\"Unsichtbar\" \n")
        for se in contact_set:
            sitemap.write("            Default item=" + se[0].name + " label=\"" + se[0].label + " " + se[1] + "\" icon=" + se[0].icon + "\n")
        sitemap.write("        }\n")
    sitemap.write("    }\n")
    sitemap.write("}\n")
    sitemap.close()


# Erstellt eine Textdatei für die Kachelansicht
def create_habpanel(floors):
    habpanel.write("{\n    \"dashboards\": [\n")
    tempString = ""
    for floor in floors.values():
        if floor_check(floor):
            if len(floor.rooms) == 0:  # wenn die Etage keine Räume hat, dann hat er Items und diese werden hinzugefügt
                tempString += "        {\n"
                tempString += write_room_first(floor)
                tempString += write_room_second()
                tempString += "            \"widgets\": [\n"
                for item in floor.items:
                    tempString += write_widget(item)
                    increasePosition(False)
                clearPosition()
                tempString = tempString[:-2]
                tempString += "\n"
                tempString += "        ]\n"
                # tempString += write_room_second()
                increasePosition(True)
                tempString += "    },\n"
            for room in floor.rooms.values():  # Wenn die Etage Räume hat, werden die Items der Räume und die Items des Flurs in dem Raum erstellt
                if len(room.items) != 0:
                    tempString += "        {\n"
                    tempString += write_room_first(room, floor.name)
                    tempString += write_room_second()
                    tempString += "            \"widgets\": [\n"
                    for item in room.items:
                        tempString += write_widget(item)
                        increasePosition(False)
                    for item in floor.items:
                        tempString += write_widget(item)
                        increasePosition(False)
                    clearPosition()
                    tempString = tempString[:-2]
                    tempString += "\n"
                    tempString += "        ]\n"
                    # tempString += write_room_second()
                    increasePosition(True)
                    tempString += "    },\n"
    else:
        tempString = tempString[:-2]
        tempString += "\n"
    habpanel.write(tempString)
    habpanel.write("    ],\n")
    habpanel.write("    \"menucolumns\": 6,\n")
    habpanel.write("    \"settings\": {\n")
    habpanel.write("        \"theme\": \"default\"\n")
    habpanel.write("    },\n")
    habpanel.write(write_customwidgets())
    habpanel.write("}\n")
    habpanel.close()


# wird aufgerufen wenn der Raum gewechselt wird und man wieder oben links anfängt
def clearPosition():
    global colIndexItem
    global rowIndexItem
    rowIndexItem = 0
    colIndexItem = 0


# wird nach jedem neuem Raum aufgerufen, oder neuem Item, damit das nächste Element rechts daneben angeordnet wird
def increasePosition(isroom):
    global colIndexItem
    global rowIndexItem
    global colIndexRoom
    global rowIndexRoom
    if isroom:
        colIndexRoom += 1
        if colIndexRoom > 5:
            rowIndexRoom += 3
            colIndexRoom = 0
    else:
        colIndexItem += 1
        if colIndexItem > 11:
            rowIndexItem += 1
            colIndexItem = 0


# schreibt das Widget rein, je nach dem welches Elementtyp es ist
def write_widget(item):
    _type = channelToPanelType.get(item.channel)
    placeholder = ""
    placeholder += "                {\n"
    if _type != "template":
        placeholder += "                    \"item\": \"" + item.name + "\",\n"
    placeholder += "                    \"name\": \"" + item.label + "\",\n"
    placeholder += "                    \"sizeX\": " + Gloabl.sizeXItem + ",\n"
    placeholder += "                    \"sizeY\": " + Gloabl.sizeYItem + ",\n"
    placeholder += "                    \"type\": \"" + _type + "\",\n"
    if item.channel == "rvarsetpoint":
        placeholder += "                    \"floor\": 10,\n"
        placeholder += "                    \"ceil\": 40,\n"
        placeholder += "                    \"step\": 1,\n"
        placeholder += "                    \"unit\": \"°C\",\n"
        placeholder += "                    \"ranges\": [],\n"
        placeholder += "                    \"readOnly\": false,\n"
        placeholder += "                    \"subTextEnabled\": true,\n"
    elif "rollershutter" in item.channel:
        placeholder += "                    \"customwidget\": \"Shutter\",\n"
    placeholder += "                    \"row\": " + str(rowIndexItem) + ",\n"
    placeholder += "                    \"col\": " + str(colIndexItem) + ",\n"
    if _type != "template":
        if _type == "knob":
            placeholder += "                    \"fontSize\": " + Gloabl.regulator_size + ",\n"
        else:
            placeholder += "                    \"fontSize\": " + Gloabl.font_size + ",\n"
        if _type == "slider":
            placeholder += "                    \"unit\": \"%\",\n"
        elif _type == "dummy":
            placeholder += "                    \"unit\": \"" + unittosign.get(item.unit) + "\",\n"
        placeholder += "                    \"useserverformat\": " + Gloabl.useserverformat + ",\n"
        if _type == "knob":
            placeholder += "                    \"format\": \"%.1f\"\n"
        else:
            placeholder += "                    \"format\": \"%.1f\",\n"
    if _type != "knob":
        if item.icon != "Unbekannt":
            placeholder += "                    \"backdrop_iconset\": \"" + Gloabl.iconset + "\",\n"
            placeholder += "                    \"backdrop_icon\": \"" + item.icon + "\",\n"
            placeholder += "                    \"backdrop_center\": true,\n"
        if item.icon == "motion" or item.icon == "window" or "rollershutter" in item.channel:
            placeholder += "                    \"icon_size\": " + Gloabl.icon_sizeItem + ",\n"
        else:
            placeholder += "                    \"icon_size\": " + Gloabl.icon_sizeItem + "\n"
    if item.icon == "motion" or item.icon == "window":
        placeholder += "                    \"hideicon\": true,\n"
        placeholder += "                    \"hideonoff\": true\n"
    if "rollershutter" in item.channel:
        placeholder += "                    \"config\": {\n"
        placeholder += "                        \"shutter_item\": \"" + item.name + "\",\n"
        placeholder += "                        \"shutter_label\": \"" + item.label + "\",\n"
        placeholder += "                        \"icon_size\": " + Gloabl.icon_sizeItem + ",\n"
        placeholder += "                        \"fontSize\": " + Gloabl.font_size + "\n"
        placeholder += "                    }\n"
    placeholder += "                },\n"
    return placeholder


# schreibt ein Raumwidget
def write_room_first(room, name_floor=""):
    placeholder = ""
    placeholder += "            \"id\": \"" + room.name + "_" + name_floor + "\",\n"
    placeholder += "            \"name\": \"" + room.name + "(" + floornametoabk.get(name_floor, name_floor) + ")" + "\",\n"
    placeholder += "            \"row\": " + str(rowIndexRoom) + ",\n"
    placeholder += "            \"col\": " + str(colIndexRoom) + ",\n"
    placeholder += "            \"tile\": {\n"
    if room.icon != "Unbekannt":
        placeholder += "                \"backdrop_iconset\": \"" + Gloabl.iconset + "\",\n"
        placeholder += "                \"backdrop_icon\": \"" + room.icon + "\",\n"
        placeholder += "                \"backdrop_center\": true,\n"
        placeholder += "                \"iconset\": \"" + Gloabl.iconset + "\",\n"
        placeholder += "                \"icon\": \"" + room.icon + "\",\n"
        placeholder += "                \"icon_size\": " + Gloabl.icon_sizeRoom + "\n"
    placeholder += "            },\n"
    return placeholder


def write_room_second():
    placeholder = ""
    placeholder += "            \"sizeX\": " + Gloabl.sizeXRoom + ",\n"
    placeholder += "            \"sizeY\": " + Gloabl.sizeYRoom + ",\n"
    return placeholder


# Für Rollläden hat die Kachelansicht kein Widget, deswegen ein eigenes bzw. aus der Community
def write_customwidgets():
    placeholder = ""
    placeholder += "    \"customwidgets\": {\n"
    placeholder += "            \"Shutter\": {\n"
    placeholder += "                 \"template\": \"<style>\\n#shutter_table, #shutter_td {\\n    border: 0px;\\n    padding: 3px;\\n    font-size: {{config.font_size}}px;\\n    text-align: center;\\n}\\n#shutter_table {\\n    border-collapse: collapse;\\n    width: 100%;\\n}\\n</style>\\n<table id=\\\"shutter_table\\\">\\n    <tr>\\n    <td id=\\\"shutter_row1\\\">\\n      <span>\\n  \\t<widget class=\\\"glyphicon glyphicon-menu-up\\\" style=\\\"font-size:{{config.icon_size}}px\\\" ng-click=\\\"sendCmd(config.shutter_item, 'UP')\\\" />\\n\\t</span></td>\\n        <td id=\\\"shutter_row1\\\">\\n      <span>\\n  \\t<widget-icon iconset=\\\"'eclipse-smarthome-classic'\\\" icon=\\\"'blinds'\\\" size=\\\"config.icon_size\\\" state=\\\"itemState(config.shutter_item)\\\" ng-click=\\\"sendCmd(config.shutter_item, 'STOP')\\\" />\\n\\t</span></td>\\n        <td id=\\\"shutter_row1\\\">\\n      <span>\\n  \\t<widget class=\\\"glyphicon glyphicon-menu-down\\\" style=\\\"font-size:{{config.icon_size}}px\\\" ng-click=\\\"sendCmd(config.shutter_item, 'DOWN')\\\" />\\n\\t</span></td>\\n  </tr>\\n</table>\\n <td id=\\\"shutter_td\\\">{{config.shutter_label}}</td>\",\n"
    placeholder += "                 \"name\": \"Rollershutter simple\",\n"
    placeholder += "                 \"author\": \"Mclassen(re-write)\",\n"
    placeholder += "                 \"description\": \"rollershutters, Window coving, Blind\",\n"
    placeholder += "                 \"settings\": [\n"
    placeholder += "                     {\n"
    placeholder += "                         \"type\": \"item\",\n"
    placeholder += "                         \"id\": \"shutter_item\",\n"
    placeholder += "                         \"label\": \"Shutter item\",\n"
    placeholder += "            \"default\": \"Shutter\"\n"
    placeholder += "                        },\n"
    placeholder += "               {\n"
    placeholder += "             \"type\": \"string\",\n"
    placeholder += "                \"default\": \"Shutter\",\n"
    placeholder += "               \"label\": \"Shutter label\",\n"
    placeholder += "               \"id\": \"shutter_label\"\n"
    placeholder += "                  },\n"
    placeholder += "                    {\n"
    placeholder += "                    \"type\": \"number\",\n"
    placeholder += "                  \"id\": \"icon_size\",\n"
    placeholder += "                      \"label\": \"Icon Size\",\n"
    placeholder += "                      \"default\": \"50\"\n"
    placeholder += "                     },\n"
    placeholder += "                    {\n"
    placeholder += "                   \"type\": \"number\",\n"
    placeholder += "                   \"id\": \"font_size\",\n"
    placeholder += "                     \"label\": \"Font size\",\n"
    placeholder += "                     \"default\": \"16\"\n"
    placeholder += "                    }\n"
    placeholder += "                 ],\n"
    placeholder += "                \"readme_url\": \"https://community.openhab.org/t/60831\"\n"
    placeholder += "              }\n"
    placeholder += "              }\n"
    return placeholder
