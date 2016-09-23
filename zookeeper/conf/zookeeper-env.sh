{%- from 'zookeeper/settings.sls' import zk with context -%}

{%- if jvm_opts == 'None' -%}
{%- set jvm_opts = "" -%}
{%- endif -%}
export ZOO_LOG4J_PROP={{ log_level }},ROLLINGFILE
export ZOO_LOG_DIR={{ zk.data_log_dir }}
export ZOOPIDFILE={{ zk.data_dir }}/zookeeper-server.pid
export JAVA_HOME={{ java_home }}
export SERVER_JVMFLAGS="-Xms{{ initial_heap_size }}m -Xmx{{ max_heap_size }}m -XX:MaxPermSize={{ max_perm_size }}m {{ jvm_opts }} -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1 -Dcom.sun.management.jmxremote.port={{ jmx_port }}"
