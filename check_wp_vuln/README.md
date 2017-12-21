# check_wp_vuln
will use the API at wpvulndb.com to query for version number, plugin, or theme vulnerabilities
# how to use:
```
./check_wp_vuln.sh --theme zerif-lite
{
    "zerif-lite": {
        "latest_version": "1.8.5.6",
        "last_updated": "2016-12-08T00:00:00.000Z",
        "popular": false,
        "vulnerabilities": []
    }
}
```	
