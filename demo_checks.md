disk.json
```
{
    "check": {
        "name": "Disk Util",
        "interval": "60s",
        "notes": "Critical 5%, warning 10% free",
        "script": "/usr/lib/nagios/plugins/check_disk -w 10% -c 5% -p /"
    }
}
```

load.json
```
{
    "check": {
        "name": "Load Avg",
        "interval": "30s",
        "notes": "Critical load average 2, warning load average 1",
        "script": "/usr/lib/nagios/plugins/check_load -w 1,1,1 -c 2,2,2"
    }
}
```

memory.json
```
{
    "check": {
        "name": "Memory Util",
        "interval": "30s",
        "notes": "Critical 95% util, warning 85% util",
        "script": "/usr/lib/nagios/plugins/check_mem -w 85% -c 95%"
    }
}
```