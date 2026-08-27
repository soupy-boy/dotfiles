#!/bin/bash

sudo reflector --country US --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

