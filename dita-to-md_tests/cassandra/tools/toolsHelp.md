# nodetool help {#toolsHelp .reference}

Provides nodetool command help.

Provides nodetool command help.

## Synopsis {#synopsis .section}

```language-bash
nodetool help <*command*>
```

## Description {#description .section}

The help command provides a synopsis and brief description of each nodetool command.

## Examples {#examples .section}

Using nodetool help lists all commands and usage information. For example, nodetool help netstats provides the following information.

```
NAME
        nodetool netstats - Print network information on provided host
        (connecting node by default)

SYNOPSIS
        nodetool [(-h <host> | --host <host>)] [(-p <port> | --port <port>)]
                [(-pw <password> | --password <password>)]
                [(-u <username> | --username <username>)] netstats

OPTIONS
        -h <host>, --host <host>
            Node hostname or ip address

        -p <port>, --port <port>
            Remote jmx agent port number

        -pw <password>, --password <password>
            Remote jmx agent password

        -u <username>, --username <username>
            Remote jmx agent username

```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

