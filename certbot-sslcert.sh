#!/bin/bash
certbot --non-interactive --redirect --agree-tos --nginx -d mydomain.com -m me@example.com
