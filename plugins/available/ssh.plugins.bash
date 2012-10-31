#!/bin/bash

ssh_setup() {
    eval $(ssh-agent) && ssh-add
}
