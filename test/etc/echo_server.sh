#!/bin/bash

#pwd
java echoserver.EchoServer &
echo $! > .pid

