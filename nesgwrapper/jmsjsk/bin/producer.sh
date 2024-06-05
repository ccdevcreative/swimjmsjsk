#!/bin/sh
#*******************************************************************************
# Copyright (c) 2021 L3Harris Technologies
#
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#*******************************************************************************

CLASSPATH=../conf:$(echo ../lib/*.jar|tr ' ' ':')

SOLACE_CLASSPATH=$(echo ../lib/solace/*.jar|tr ' ' ':')
ACTIVEMQ_CLASSPATH=$(echo ../lib/activemq/*.jar|tr ' ' ':')
WEBLOGIC_CLASSPATH=$(echo ../lib/weblogic/*.jar|tr ' ' ':')

CLASSPATH=$CLASSPATH:$SOLACE_CLASSPATH:$ACTIVEMQ_CLASSPATH:$WEBLOGIC_CLASSPATH

if [ -z "$JAVA_HOME" ]; then
    JAVA=java
else
    JAVA=$JAVA_HOME/bin/java
fi

$JAVA -cp $CLASSPATH com.harris.gcsd.dex.jumpstart.Producer "$@"
