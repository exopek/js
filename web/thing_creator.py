def gatewayJSON(mac, user, pw, outputmode):
    return {
        "lcn:pckGateway:" + mac: {
            "class": "org.eclipse.smarthome.core.thing.internal.BridgeImpl",
            "value": {
                "label": "LCN-PKEV",
                "channels": [],
                "configuration": {
                    "properties": {
                        "mode": outputmode,
                        "hostname": "localhost",
                        "password": pw,
                        "port": 4114,
                        "timeoutMs": 3500,
                        "username": user
                    }
                },
                "properties": {
                    "macAddress": mac
                },
                "uid": {
                    "segments": [
                        "lcn",
                        "pckGateway",
                        mac
                    ]
                },
                "thingTypeUID": {
                    "segments": [
                        "lcn",
                        "pckGateway"
                    ]
                }
            }
        }
    }


def thingJSON(mac, segID, modID, modName, serialNo):
    true = True
    return {"lcn:module:" + mac + ":S" + segID + "M" + modID: {
        "class": "org.eclipse.smarthome.core.thing.internal.ThingImpl",
        "value": {
            "label": modName,
            "bridgeUID": {
                "segments": [
                    "lcn",
                    "pckGateway",
                    mac
                ]
            },
            "channels": [
                {
                    "acceptedItemType": "Dimmer",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "output#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "output"
                        ]
                    },
                    "label": "Output 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Dimmer",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "output#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "output"
                        ]
                    },
                    "label": "Output 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Dimmer",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "output#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "output"
                        ]
                    },
                    "label": "Output 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Dimmer",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "output#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "output"
                        ]
                    },
                    "label": "Output 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Color",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "output#color"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "color"
                        ]
                    },
                    "label": "RGB Color Control (Outputs 1-3)",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Rollershutter",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rollershutteroutput#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rollershutter"
                        ]
                    },
                    "label": "Shutter 1-2",
                    "configuration": {
                        "properties": {
                            "invertUpDown": "false"
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#9"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 9",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#10"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 10",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#11"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 11",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "led#12"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "led"
                        ]
                    },
                    "label": "LED 12",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "relay#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "relay"
                        ]
                    },
                    "label": "Relay 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Rollershutter",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rollershutterrelay#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rollershutter"
                        ]
                    },
                    "label": "Shutter 1-2",
                    "configuration": {
                        "properties": {
                            "invertUpDown": "false"
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Rollershutter",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rollershutterrelay#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rollershutter"
                        ]
                    },
                    "label": "Shutter 3-4",
                    "configuration": {
                        "properties": {
                            "invertUpDown": "false"
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Rollershutter",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rollershutterrelay#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rollershutter"
                        ]
                    },
                    "label": "Shutter 5-6",
                    "configuration": {
                        "properties": {
                            "invertUpDown": "false"
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Rollershutter",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rollershutterrelay#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rollershutter"
                        ]
                    },
                    "label": "Shutter 7-8",
                    "configuration": {
                        "properties": {
                            "invertUpDown": "false"
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "logic#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "logic"
                        ]
                    },
                    "label": "Logic Operation 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "logic#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "logic"
                        ]
                    },
                    "label": "Logic Operation 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "logic#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "logic"
                        ]
                    },
                    "label": "Logic Operation 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "String",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "logic#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "logic"
                        ]
                    },
                    "label": "Logic Operation 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 1",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 2",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 3",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 4",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 5",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 6",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 7",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Contact",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "binarysensor#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "binarysensor"
                        ]
                    },
                    "label": "Binary Sensor 8",
                    "configuration": {
                        "properties": {
                            "invertState": true
                        }
                    },
                    "properties": {},
                    "defaultTags": [],

                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 1 or TVar",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 5",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 6",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 7",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 8",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#9"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 9",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#10"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 10",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#11"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 11",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "variable#12"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Variable 12",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rvarsetpoint#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "R1Var Setpoint",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rvarsetpoint#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "R2Var Setpoint",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rvarlock#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rvarlock"
                        ]
                    },
                    "label": "R1Var Lock",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],

                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "rvarlock#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "rvarlock"
                        ]
                    },
                    "label": "R2Var Lock",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": [],
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister1#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 1",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister1#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister1#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister1#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister1#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 5",
                    "description": "Only before Feb. 2013",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister2#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 1",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister2#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister2#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister2#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister3#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 1",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister3#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister3#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister3#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister4#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 1",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister4#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister4#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "thresholdregister4#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "Threshold 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "s0input#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "S0 Counter 1",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "s0input#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "S0 Counter 2",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "s0input#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "S0 Counter 3",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Number",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "s0input#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "variable"
                        ]
                    },
                    "label": "S0 Counter 4",
                    "configuration": {
                        "properties": {
                            "unit": "native",
                            "parameter": 1000
                        }
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablea#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktableb#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktablec#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#1"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 1",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#2"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 2",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#3"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 3",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#4"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 4",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#5"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 5",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#6"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 6",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#7"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 7",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "acceptedItemType": "Switch",
                    "kind": "STATE",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "keylocktabled#8"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "keylock"
                        ]
                    },
                    "label": "Key 8",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "code#transponder"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "transponders"
                        ]
                    },
                    "label": "Transponder Codes",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "code#fingerprint"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "fingerprints"
                        ]
                    },
                    "label": "Fingerprint Codes",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "code#remotecontrolkey"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "remotecontrolkeys"
                        ]
                    },
                    "label": "Remote Control Keys",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "code#remotecontrolcode"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "remotecontrolcodes"
                        ]
                    },
                    "label": "Remote Control with Access Control Code",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "code#remotecontrolbatterylow"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "remotecontrolsbatterylow"
                        ]
                    },
                    "label": "Remote Control Low Battery",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                },
                {
                    "kind": "TRIGGER",
                    "uid": {
                        "segments": [
                            "lcn",
                            "module",
                            mac,
                            "S" + segID + "M" + modID,
                            "hostcommand#sendKeys"
                        ]
                    },
                    "channelTypeUID": {
                        "segments": [
                            "lcn",
                            "sendKeys"
                        ]
                    },
                    "label": "Send Keys",
                    "configuration": {
                        "properties": {}
                    },
                    "properties": {},
                    "defaultTags": []
                }
            ],
            "configuration": {
                "properties": {
                    "moduleId": int(modID),
                    "segmentId": int(segID)
                }
            },
            "properties": {
                "serialNumber": serialNo
            },
            "uid": {
                "segments": [
                    "lcn",
                    "module",
                    mac,
                    "S" + segID + "M" + modID,
                ]
            },
            "thingTypeUID": {
                "segments": [
                    "lcn",
                    "module"
                ]
            }
        }
    }
    }
