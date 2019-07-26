#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from lib.smartmodules.matchstrings.MatchStrings import creds_match


creds_match["mssql"] = {
    "msdat": {
        "INFO -: Valid credential: '(?P<m1>\S+)'/'(?P<m2>\S*)'": {
            "meth": "finditer",
            "user": "$1",
            "pass": "$2",
        }
    },
    "nmap": {
        "sa:<empty> => Login Success": {"meth": "finditer", "user": "sa", "pass": ""}
    },
}
