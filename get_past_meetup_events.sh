#!/bin/bash

set -x -e -u

curl -XGET "https://api.meetup.com/London-Perl-Mongers/events?page=200&status=past" | json_pp > meetup_events.json
