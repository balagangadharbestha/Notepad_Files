#!/bin/bash

aws ec2 describe-addresses --query "Addresses[?NetworkInterfaceId == null ].PublicIp" --output table

 