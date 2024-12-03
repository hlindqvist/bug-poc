#!/usr/bin/env python3

import os
import pdnsapi_client

configuration = pdnsapi_client.Configuration()
configuration.api_key["X-API-Key"] = os.getenv('PDNSAPI_KEY','')
configuration.host = os.getenv('PDNSAPI_URL', 'http://localhost:8081/api/v1')

pdnsapi_zones_client = pdnsapi_client.ZonesApi(pdnsapi_client.ApiClient(configuration))


zone = pdnsapi_client.Zone()
zone.name = "example.invalid."
zone.kind = "Master"
zone.nameservers = ["ns1.example.org."]
zone.masters = []
server_id="localhost"

result = pdnsapi_zones_client.create_zone(zone, server_id)

print(result)
